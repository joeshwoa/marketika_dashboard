import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import nodemailer from 'npm:nodemailer@6.9.10'

const transporter = nodemailer.createTransport({
    service: Deno.env.get('SMTP_SERVICE')!,
    auth: {
      user: Deno.env.get('SMTP_USERNAME')!,
      pass: Deno.env.get('SMTP_PASSWORD')!,
    },
});

console.log(`Function "send-email-smtp" up and running!`)

serve(async (request: Request): Promise<Response> => {
    const { emails, names }: { emails: string[]; names: string[] } =
        await request.json();

    let errorHappen = false;
    let errorTexts = [''];

    for (let i = 0; i < emails.length; i++) {
        const email = emails[i];
        const name = names[i];

        const mailOptions = {
            from: Deno.env.get('SMTP_FROM')!, // Sender address
            to: email, // List of recipients
            subject: "New Article from Marketika!",
            html: `
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f4f4f4;
                        color: #333;
                        margin: 0;
                        padding: 0;
                    }
                    .container {
                        width: 100%;
                        max-width: 600px;
                        margin: 0 auto;
                        background-color: #ffffff;
                        border: 1px solid #ddd;
                        padding: 20px;
                    }
                    .header {
                        text-align: center;
                        padding: 20px 0;
                    }
                    .header img {
                        max-width: 200px;
                        max-height: 200px;
                    }
                    .content {
                        text-align: left;
                        padding: 20px 0;
                    }
                    .content h1 {
                        color: #9279BA;
                    }
                    .content p {
                        font-size: 16px;
                        line-height: 1.6;
                    }
                    .footer {
                        text-align: center;
                        padding: 20px 0;
                        color: #777;
                        font-size: 14px;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <img src="https://i.ibb.co/WkC81hs/1.png" alt="Your Logo">
                    </div>
                    <div class="content">
                        <h1>Hello, ${name}!</h1>
                        <p>We are excited to announce that a new article has just been published on our website.</p>
                        <p>Click the link below to read the latest insights and stay updated with our newest content:</p>
                        <p><a href="https://marketika-wl23.onrender.com/" style="color: #9279BA; text-decoration: none;">Read the new article</a></p>
                        <p>Thank you for being a valued subscriber!</p>
                        <p>Best regards,</p>
                        <p>Marketika</p>
                    </div>
                    <div class="footer">
                        <p>&copy; 2024 Markitike. All rights reserved.</p>
                        <p>If you no longer wish to receive these emails, you can <a href="https://vprhyrbflnzfwxhpfwrd.supabase.co/functions/v1/unsubscribe?email=${email}" style="color: #9279BA; text-decoration: none;">unsubscribe here</a>.</p>
                    </div>
                </div>
            </body>
            </html>
            
                `,
        };

        try {
            const info = await transporter.sendMail(mailOptions);

            console.log(info);
          } catch (error) {
            console.log(error);

            errorHappen = true;
            errorTexts.push(String(error?.message));
          }
    }

    if(errorHappen) {
        return new Response(JSON.stringify({ error: errorTexts }), { status: 205 });
    } else {
        return new Response(JSON.stringify({ msg: "All emails sent"}), {
            status: 200,
            headers: {
                "Content-Type": "application/json",
            },
        });
    }

});
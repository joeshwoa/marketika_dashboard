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
                    <div>
                        <p>Hi ${name},</p>
                        <p>Marketika has a new article. Go and enjoy reading it.</p>
                        <p>From: Marketika</p>
                    </div>
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
        return new Response(JSON.stringify({ error: errorTexts }), { status: 500 });
    } else {
        return new Response(JSON.stringify({ msg: "All emails sent"}), {
            status: 200,
            headers: {
                "Content-Type": "application/json",
            },
        });
    }

});
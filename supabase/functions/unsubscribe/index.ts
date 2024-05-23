// Import the necessary modules
import { serve } from "https://deno.land/std@0.131.0/http/server.ts";
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2';

// Initialize Supabase client
const supabase = createClient(
  'https://vprhyrbflnzfwxhpfwrd.supabase.co',
  Deno.env.get('SUPABASE_ANON_KEY')!
);

console.log(`Function "unsubscribe" up and running!`)

serve(async (request: Request): Promise<Response> => {

  try {
    // Get the email from the query parameters
    const url = new URL(request.url);

    
    const email = url.searchParams.get('email');

    if (!email) {
      return new Response(JSON.stringify({ error: 'Email is required' }), { status: 400 });
    }

    // Delete the user from the subscribers table

    const { data, error } = await supabase
      .from('subscribers')
      .delete()
      .eq('email', email);

    if (error) {
      throw error;
    }

    return new Response(JSON.stringify({ message: 'Unsubscribed successfully' }), { status: 200 });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 });
  }

});

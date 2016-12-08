From: christopher.lee.bostic@gmail.com (Christopher Bostic)
Date: Thu, 8 Dec 2016 13:43:33 -0600
Subject: [PATCH 08/16] drivers/fsi: Add crc4 helpers
In-Reply-To: <81146f25-05fa-70f9-e8ff-49c17aede8f2@ozlabs.org>
References: <1481076574-54711-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481076574-54711-2-git-send-email-christopher.lee.bostic@gmail.com>
 <20161207090219.GA14742@kroah.com>
 <81146f25-05fa-70f9-e8ff-49c17aede8f2@ozlabs.org>
Message-ID: <CAA0LjjVuHoggi+vMHMo6OFRfVxY7im5pEAYPGUefrci7NjPncg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 5:33 PM, Jeremy Kerr <jk@ozlabs.org> wrote:
> Hi Greg,
>
>> Why not just create lib/crc4.c with these functions, like the other crc
>> functions in the kernel?
>
> Two (bad) reasons:
>
>  - The crc4 implementation here is pretty specific to the FSI
>    usage (only supporting 4-bit-sized chunks), to keep the math & lookup
>    table simple
>
>  - I'm lazy
>
> So yes, we should spend the effort now to make this generic enough for
> a lib/crc4.c. Would we want to support different values for the
> polynomial?
>
> Chris: do you want me to to that, or will you?

Hi Jeremy,

I'll take this one.  Will implement as per Greg's suggestions.

Thanks,
Chris

>
> Cheers,
>
>
> Jeremy

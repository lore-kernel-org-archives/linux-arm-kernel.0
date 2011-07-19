From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 19 Jul 2011 14:26:50 +0530
Subject: [PATCH] davinci: fix DM365 EVM video input mux bits
In-Reply-To: <1311046211-2849-1-git-send-email-jon.povey@racelogic.co.uk>
References: <1311046211-2849-1-git-send-email-jon.povey@racelogic.co.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DBDC68A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jul 19, 2011 at 09:00:11, Jon Povey wrote:
> Video input mux settings for tvp7002 and imager inputs were swapped.
> Comment was correct.
> 
> Tested on EVM with tvp7002 input.
> 
> Signed-off-by: Jon Povey <jon.povey@racelogic.co.uk>

Thanks for the fix.

Since this part of the code hasn't changed since it
was written, this is a good candidate for stable
kernel series. You can just add:

Cc: stable at kernel.org

Also, this way if the fix fails to make it to 3.0,
it can make it into its stable series. I will add
the Cc line when I queue this patch.

> ---
> As a bugfix maybe this should try to get into 3.0?

I am going queue this to Arnd for sending it for v3.0.
He hasn't yet picked up my earlier pull request yet so
keep fingers crossed :)

BTW, I changed the subject to:

"davinci: DM365 EVM: fix video input mux bits"

Nothing really wrong with what you had, just that
I prefer it this way.

Thanks,
Sekhar

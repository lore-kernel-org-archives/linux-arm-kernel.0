From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Sat, 3 Nov 2012 08:24:10 +0000
Subject: [PATCH 01/15] ARM: OMAP2+: mailbox: Add an API for flushing the
 FIFO
In-Reply-To: <20121102190002.GA15766@atomide.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-2-git-send-email-vaibhav.bedia@ti.com>
 <20121102190002.GA15766@atomide.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EBFE5AE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Sat, Nov 03, 2012 at 00:30:04, Tony Lindgren wrote:
[...]
> 
> Patches have been posted to move the mailbox related
> files out of arch/arm, so you'll have to update those
> for that. Please see thread "[PATCH 0/2] ARM: OMAP:
> mailbox out of plat code" for more information.
> 

Thanks for pointing this out. I'll update the patches for these.

I had used your master branch as the baseline. Some of the patches
also need rework to account the header file and timer code changes.
Is there some other branch of yours that I could use or should I
just mention the dependencies in the next version of patches?

Regards,
Vaibhav 

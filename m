From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jul 2015 23:41:33 -0700
Subject: [PATCH 0/2] ARM-OMAP2+: Deletion of unnecessary checks before
 two function calls
In-Reply-To: <558BE713.1020409@users.sourceforge.net>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <558BE713.1020409@users.sourceforge.net>
Message-ID: <20150715064132.GZ17550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* SF Markus Elfring <elfring@users.sourceforge.net> [150625 04:35]:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 25 Jun 2015 13:24:35 +0200
> 
> Some functions which release a system resource tolerate the passing
> of a null pointer. I do not see a need because of this fact
> that a function caller repeats a corresponding check.
> 
> Markus Elfring (2):
>   Delete a check before the function call "omap_device_delete"
>   Delete a check before the function call "of_node_put"
> 
>  arch/arm/mach-omap2/omap_device.c | 3 +--
>  arch/arm/mach-omap2/timer.c       | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applying both into omap-for-v4.3/soc thanks.

Tony

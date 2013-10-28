From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Oct 2013 10:52:00 +0800
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <526DCED3.2070704@mentor.com>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
 <5264A06B.2040202@mentor.com>
 <20131021045917.GH17165@S2101-09.ap.freescale.net>
 <857E9EDCA6C0904DB3357321AA9123EB62506BEA@NA-MBX-01.mgc.mentorg.com>
 <5264C615.4070504@mentor.com>
 <20131021070451.GI17165@S2101-09.ap.freescale.net>
 <526DCED3.2070704@mentor.com>
Message-ID: <20131028025159.GD2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 07:41:23PM -0700, jiada wrote:
> Hi Shawn
> 
> On 10/21/2013 12:04 AM, Shawn Guo wrote:
> >On Sun, Oct 20, 2013 at 11:13:41PM -0700, jiada wrote:
> >>I tried to checkout upstream kernel at commit: f36854c
> >>even without your "ARM: imx: replace imx6q_restart() with
> >>mxc_restart()" patch
> >>I can reproduce system hang issue by "echo b > /proc/sysrq-trigger"
> >
> >Since the patch hasn't hit upstream tree, you meant you can reproduce
> >the issue on linux-next or my for-next branch?  What's the reproducing
> >rate?  I ran a few iterations but did not hit it.
> >
> >Shawn
> >
> 
> as per discussion locally, when do you think you will post the fix patch
> for the system hang I observed?
> I would like to test for your patch, and then pull it to my kernel.

I will do it today.

Shawn

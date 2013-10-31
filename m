From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 31 Oct 2013 13:23:26 +0800
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <20131030175426.GK16735@n2100.arm.linux.org.uk>
References: <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
 <5264A06B.2040202@mentor.com>
 <20131021045917.GH17165@S2101-09.ap.freescale.net>
 <857E9EDCA6C0904DB3357321AA9123EB62506BEA@NA-MBX-01.mgc.mentorg.com>
 <5264C615.4070504@mentor.com>
 <20131021070451.GI17165@S2101-09.ap.freescale.net>
 <526DCED3.2070704@mentor.com>
 <20131028074524.GE2839@S2101-09.ap.freescale.net>
 <5270793E.9000605@mentor.com>
 <20131030175426.GK16735@n2100.arm.linux.org.uk>
Message-ID: <20131031052324.GA14308@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 05:54:26PM +0000, Russell King - ARM Linux wrote:
> The test you really want to do is a reboot via serial console: <break> b.
> That's definitely the one which will get you if your restart handler has
> anything in it which sleeps.  This will definitely call the restart
> handler from IRQ context.

Yea, I tested it.

Shawn

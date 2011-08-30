From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 30 Aug 2011 22:56:07 +0800
Subject: [PATCH] arm: mach-imx: enable all uart clocks for DEBUG_LL
In-Reply-To: <1314269856-20000-1-git-send-email-w.sang@pengutronix.de>
References: <1314269856-20000-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110830145606.GB19359@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 12:57:36PM +0200, Wolfram Sang wrote:
> If you want to move the DEBUG_LL uart, simply changing the base address
> in debug-macro.S will not be enough. One needs to enable the correct
> clock during clock init, too, otherwise the kernel remains silent. This
> is too easy to forget, so enable all uart clocks for DEBUG_LL to save
> precious developer time.
> 
I guess the patch is not welcomed from the power management POV.
Shouldn't bootloader have enabled the clock for debug uart anyway?

-- 
Regards,
Shawn

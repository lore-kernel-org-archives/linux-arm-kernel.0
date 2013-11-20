From: tj@kernel.org (Tejun Heo)
Date: Wed, 20 Nov 2013 10:13:09 -0500
Subject: [RESEND PATCH 1/6] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
In-Reply-To: <201311201611.44120.marex@denx.de>
References: <1384942659-5362-1-git-send-email-marex@denx.de>
 <1384943242-8201-1-git-send-email-marex@denx.de>
 <20131120145907.GA28946@htj.dyndns.org>
 <201311201611.44120.marex@denx.de>
Message-ID: <20131120151309.GC28946@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 04:11:43PM +0100, Marek Vasut wrote:
> It's already done in 2/6 of the series, I hope that is OK. Otherwise I can 
> separate this formating change from the 2/6 patch and shove it in front of this 
> one even. Which one do you prefer please?

Oops, sorry about missing that.  As long as the end result is correct,
I don't mind either way.

Thanks!

-- 
tejun

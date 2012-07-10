From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 11 Jul 2012 00:08:58 +0800
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207101751.12903.marex@denx.de>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <201207101737.15379.marex@denx.de>
 <20120710154509.GC11813@S2101-09.ap.freescale.net>
 <201207101751.12903.marex@denx.de>
Message-ID: <20120710160856.GD11813@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2012 at 05:51:12PM +0200, Marek Vasut wrote:
> But at least it's quite consistent and it's easy to locate your board since you 
> usually know the cpu type. If you shove in just <boardname>.dts, it'll soon 
> become horrible mess.
> 
Ok, I could send a follow-up patch to rename the files.  But the
compatible string of the board will stay as the board name.

-- 
Regards,
Shawn

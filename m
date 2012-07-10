From: marex@denx.de (Marek Vasut)
Date: Tue, 10 Jul 2012 18:26:25 +0200
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <20120710160856.GD11813@S2101-09.ap.freescale.net>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <201207101751.12903.marex@denx.de>
 <20120710160856.GD11813@S2101-09.ap.freescale.net>
Message-ID: <201207101826.25741.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Tue, Jul 10, 2012 at 05:51:12PM +0200, Marek Vasut wrote:
> > But at least it's quite consistent and it's easy to locate your board
> > since you usually know the cpu type. If you shove in just
> > <boardname>.dts, it'll soon become horrible mess.
> 
> Ok, I could send a follow-up patch to rename the files.  But the
> compatible string of the board will stay as the board name.

The compatible string is all right, my concern is just the mess in the file 
names. Look at imx{51,53,6q}, kirkwood, tegra20, ... let's make it nicely at the 
begining, it's just a matter of simple git mv and git commit --amend ;-)

Best regards,
Marek Vasut

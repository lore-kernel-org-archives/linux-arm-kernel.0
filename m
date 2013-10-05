From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 10:28:09 +0800
Subject: [PATCH] ARM: imx: Include linux/err.h
In-Reply-To: <20131005022422.GF2734@S2101-09.ap.freescale.net>
References: <1380542691-24756-1-git-send-email-treding@nvidia.com>
 <20131005022422.GF2734@S2101-09.ap.freescale.net>
Message-ID: <20131005022806.GA3739@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 05, 2013 at 10:24:23AM +0800, Shawn Guo wrote:
> On Mon, Sep 30, 2013 at 02:04:51PM +0200, Thierry Reding wrote:
> > The IS_ERR() macro is defined in the linux/err.h header file, so include
> > it explicitly.
> 
> Hmm, I can not find IS_ERR() in arch/arm/mach-imx/cpu.c

Sorry, I did not look at the correct tree.

Applied, thanks.

Shawn

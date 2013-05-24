From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 May 2013 09:55:37 +0100
Subject: [PATCH 0/6] ARM: ux500: Update configurations for SD/SDIO/(e)MMC
In-Reply-To: <20130524085451.GU22683@gmail.com>
References: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
 <20130524085451.GU22683@gmail.com>
Message-ID: <20130524085537.GV22683@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 May 2013, Lee Jones wrote:

> On Thu, 23 May 2013, Ulf Hansson wrote:
> 
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > This patchset includes especially enablement for UHS-I SD cards, but
> > also some cleanups and additional enabling of SD/SDIO/(e)MMC features.
> > 
> > These changes shall also be adapted to the corresponding DT files,
> > but that is left as a separate task and outside this patchset.
> > 
> > Ulf Hansson (6):
> >   ARM: ux500: Enable 100MHz for SD/SDIO/MMC devices
> >   ARM: ux500: Don't set plf ocr mask for SD/MMC device
> >   ARM: ux500: Enable support for RPMB and Reliable Write for eMMC
> >   ARM: ux500: Enable support for discard for MMC/SD
> >   ARM: ux500: Set eMMC and WLAN card slot as non-removable
> >   ARM: ux500: Enable support for UHS-I SD-cards
> > 
> >  arch/arm/mach-ux500/board-mop500-sdi.c |   34 +++++++++++++++++++++-----------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> > 
> 
> All patches look good to me, although you should probably try to use
> the full 72 char limit per line in all of your commit messages.

Whoops! In case you couldn't tell that was an:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

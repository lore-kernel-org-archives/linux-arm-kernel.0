From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 11 Oct 2012 20:04:06 +0200
Subject: [PATCH 1/2] ARM: nomadik: switch over to using the FSMC driver
In-Reply-To: <1349953632.12014.8.camel@sauron.fi.intel.com>
References: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
 <1349953632.12014.8.camel@sauron.fi.intel.com>
Message-ID: <20121011180406.GX12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:07 Thu 11 Oct     , Artem Bityutskiy wrote:
> On Thu, 2012-10-04 at 09:28 +0200, Linus Walleij wrote:
> > The Nomadik NAND driver is really just a subset of the existing
> > FSMC driver, so let's switch over to using that driver instead,
> > since it handles more variants of this chip. The callbacks for
> > setting up the chip is doing stuff now handled by the FSMC
> > driver.
> > 
> > Cc: Alessandro Rubini <rubini@unipv.it>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Pushed both to l2-mtd.git, thanks!
wait on this one Linus said he will send an other version based on my patch
for fmsc

Best Regards,
J.
> 
> -- 
> Best Regards,
> Artem Bityutskiy



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

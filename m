From: mturquette@ti.com (Mike Turquette)
Date: Thu, 11 Oct 2012 16:49:52 -0700
Subject: [PATCH 1/2] ARM: nomadik: switch over to using the FSMC driver
In-Reply-To: <CACRpkdYMz05DwtLtHkggvo8VFOtvPLpovwq6fLceeiFK0Wci0Q@mail.gmail.com>
References: <1349335709-13399-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdYMz05DwtLtHkggvo8VFOtvPLpovwq6fLceeiFK0Wci0Q@mail.gmail.com>
Message-ID: <20121011234952.2941.18793@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-10-05 05:52:06)
> On Thu, Oct 4, 2012 at 9:28 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > The Nomadik NAND driver is really just a subset of the existing
> > FSMC driver, so let's switch over to using that driver instead,
> > since it handles more variants of this chip. The callbacks for
> > setting up the chip is doing stuff now handled by the FSMC
> > driver.
> >
> > Cc: Alessandro Rubini <rubini@unipv.it>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > I'm requesting Mike Turquette's ACK on this patch so I can merge
> > it through ARM SoC.
> 
> Still requesting Mike's ACK, but not for merging through ARM SoC
> but through MTD.
> 

Sorry for the late response but I just returned from vacation.  Might be
too late but:

Acked-by: Mike Turquette <mturquette@linaro.org>

Thanks,
Mike

> If you apply Jean-Christophe's patch first (please do that) I will
> send a v2 of this patch set to be applied onto MTD as well
> (should be OK).
> 
> Yours,
> Linus Walleij

From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Oct 2012 16:19:47 +0100
Subject: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
In-Reply-To: <CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
 <20121011134458.GB15428@gmail.com>
 <CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
Message-ID: <20121011151947.GD15428@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Oct 2012, Linus Walleij wrote:

> On Thu, Oct 11, 2012 at 3:44 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> >> Patches are based on Linus Torvalds tree with latest commit as of okt 10.
> >
> > Hmm... I get:
> >
> > Applying: clk: ux500: Support for prcmu_scalable_rate clock
> > error: drivers/clk/ux500/clk-prcmu.c: does not exist in index
> > error: drivers/clk/ux500/clk.h: does not exist in index
> > Patch failed at 0001 clk: ux500: Support for prcmu_scalable_rate clock
> >
> > So when did drivers/clk/ux500/* arrive?
> 
> Exactly here, 10 days ago on Torvalds' master branch:

Ah I see. Basing patches on commits half way through the merge
window. Good move! ;)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

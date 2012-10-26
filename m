From: mturquette@ti.com (Mike Turquette)
Date: Fri, 26 Oct 2012 11:03:49 -0700
Subject: [PATCH 0/8] clk: ux500: Fixup smp_twd clk for clk notifiers
In-Reply-To: <CACRpkdYdzvdJc=+gnRDEue1uZApGTc-P2pQfLAJXc_uBZLSPkQ@mail.gmail.com>
References: <1349869349-8070-1-git-send-email-ulf.hansson@stericsson.com>
 <20121011134458.GB15428@gmail.com>
 <CACRpkdYEukMzMX1Q8nb5zKPMZEZfttzWVC24aOkv2g8SCQtTnQ@mail.gmail.com>
 <20121011151947.GD15428@gmail.com>
 <CAPDyKFof65xAVyOo3FrdS2uYQwB1Wq3553PKj04FR6JXaJsH6Q@mail.gmail.com>
 <CACRpkdYdzvdJc=+gnRDEue1uZApGTc-P2pQfLAJXc_uBZLSPkQ@mail.gmail.com>
Message-ID: <20121026180349.3141.76336@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-10-26 01:57:49)
> On Fri, Oct 26, 2012 at 10:19 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > Samuel, a kind reminder on this, trying to collect acks to be able to
> > advise Mike to take this series through his clk tree. There are two
> > mfd patches.
> > [PATCH 2/8] mfd: db8500: Provide cpufreq table as platform data
> > [PATCH 5/8] mfd: db8500: Connect ARMSS clk to ARM OPP
> 
> Two weeks of slack for review is good enough, involved
> subsystem maintainers have been Cc:ed.
> 
> Mike T, can you just apply the patches please.
> 

Would be better to get ACKs but enough time has passed.  I'll take these
into clk-next (which will get built while I fly to Copenhagen for LCE).

Expect to see a new clk-next on Monday.

Regards,
Mike

> Yours,
> Linus Walleij

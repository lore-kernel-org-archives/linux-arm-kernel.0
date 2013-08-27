From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Aug 2013 16:45:25 -0700
Subject: [PATCH] clk: samsung: pll: Use new registration method for
 PLL6552 and PLL6553
In-Reply-To: <521CDEDE.1070003@samsung.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
 <158901ce9b34$c0ac8720$42059560$@org> <20130820002258.4443.34197@quantum>
 <1856348.DCxTucbm8V@flatron> <20130827011422.8231.95092@quantum>
 <521CDEDE.1070003@samsung.com>
Message-ID: <20130827234525.8231.17145@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kukjin Kim (2013-08-27 10:16:14)
> On 08/27/13 10:14, Mike Turquette wrote:
> > Quoting Tomasz Figa (2013-08-20 17:33:21)
> >> This patch modifies PLL6552 and PLL6553 clock drivers to use recently
> >> added common Samsung PLL registration method.
> >>
> >> Signed-off-by: Tomasz Figa<tomasz.figa@gmail.com>
> >
> > Sigh. This change won't apply on top of clk-next-s3c64xx since it
> > requires Yadwinder's change (amongst) others.
> >
> > The best I could do was spin out another topic branch with the relevant
> > changes and apply this patch on top. It is a subset of clk-next but it
> > is almost entirely Samsung patches:
> >
> > git://git.linaro.org/people/mturquette/linux.git clk-next-s3c64xx-delta
> >
> > Kukjin&  Tomasz, let me know if this OK for you to add as a dependency
> > to the Samsung tree. If it is I will merge it into clk-next, but I want
> > your OK that this branch is OK for you to take.
> >
> Hi Mike,
> 
> I merged the branch clk-next-s3c64xx-delta you provided on top of 
> previous clk-next-s3c64xx for common-clk-s3c64xx and dt-s3c64xx and it 
> looks fine to me.

Cool. I've merged it into clk-next as well.

Regards,
Mike

> 
> Thanks,
> Kukjin

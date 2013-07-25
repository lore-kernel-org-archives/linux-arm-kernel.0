From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 25 Jul 2013 10:44:16 -0700
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <51F0F035.8010705@arm.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
 <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
 <51F0F035.8010705@arm.com>
Message-ID: <20130725174416.7598.73819@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jonathan Austin (2013-07-25 02:30:29)
> On 24/07/13 20:32, Linus Walleij wrote:
> > On Tue, Jul 23, 2013 at 5:42 PM, Jonathan Austin
> > <jonathan.austin@arm.com> wrote:
> >
> >> The order of arguments in the call to vco_set() for the ICST clocks appears to
> >> have been switched in error, which results in the VCO not being initialised
> >> correctly. This in turn stops the integrated LCD on things like Integrator/CP
> >> from working correctly.
> >>
> >> This patch fixes the order and restores the expected functionality.
> >>
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: Mike Turquette <mturquette@linaro.org>
> >> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> >
> > Good catch! Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > You should probably mark this for stable as well.
> >
> 
> Mike, will you add Cc: stable when you take the fix or shall I resubmit 
> the patch somehow else?

I'll add it.

Regards,
Mike

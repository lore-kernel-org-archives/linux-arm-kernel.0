From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 30 Aug 2013 18:36:37 +0100
Subject: [PATCH] ARM: dts: vexpress: Add CCI node to TC2 device-tree
In-Reply-To: <CAOesGMhwqqOuSwVEukpfqM00BV2i=fQRhLUaf-wf-iVGR_mNbg@mail.gmail.com>
References: <1377872760.3655.48.camel@linaro1.home>
 <20130830161327.GA10045@e102568-lin.cambridge.arm.com>
 <CAOesGMhwqqOuSwVEukpfqM00BV2i=fQRhLUaf-wf-iVGR_mNbg@mail.gmail.com>
Message-ID: <20130830173636.GB10045@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 05:30:17PM +0100, Olof Johansson wrote:
> On Fri, Aug 30, 2013 at 9:13 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> 
> > Now that MCPM and CPU idle are heading to mainline, it should get queued asap,
> > thanks for that, probably as a fix at -rc1, since it is quite late now.
> 
> This is not a regression, it's a missing piece of a feature. It's not
> post-rc1 material.

It is an incomplete dts, which has been true since the dts file for TC2 has
been merged in the kernel or better since the CCI bindings got merged in
the kernel.

> It's also an indication that nobody actually tested the feature branch
> before the pull request was sent. Hrmpf.

It has been tested and we were aware that the dts in the kernel was missing
the CCI node, we were not really sure about what to do given the ongoing
discussions on dts in the kernel and so on and considered that we might
get the patch in as a fix eventually; we made a mistake, sorry.

> Shouldn't you be updating some vexpress_defconfig and probably
> multi_v7_defconfig to at least get some build coverage for this as
> well, by the way?
> 
> I really should hold this off for 3.13, but I'll apply it to the late/
> branch anyway.

Thanks,
Lorenzo

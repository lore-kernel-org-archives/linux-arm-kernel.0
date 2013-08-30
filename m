From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 Aug 2013 09:30:17 -0700
Subject: [PATCH] ARM: dts: vexpress: Add CCI node to TC2 device-tree
In-Reply-To: <20130830161327.GA10045@e102568-lin.cambridge.arm.com>
References: <1377872760.3655.48.camel@linaro1.home>
 <20130830161327.GA10045@e102568-lin.cambridge.arm.com>
Message-ID: <CAOesGMhwqqOuSwVEukpfqM00BV2i=fQRhLUaf-wf-iVGR_mNbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 9:13 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Now that MCPM and CPU idle are heading to mainline, it should get queued asap,
> thanks for that, probably as a fix at -rc1, since it is quite late now.

This is not a regression, it's a missing piece of a feature. It's not
post-rc1 material.

It's also an indication that nobody actually tested the feature branch
before the pull request was sent. Hrmpf.

Shouldn't you be updating some vexpress_defconfig and probably
multi_v7_defconfig to at least get some build coverage for this as
well, by the way?

I really should hold this off for 3.13, but I'll apply it to the late/
branch anyway.


-Olof

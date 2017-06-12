From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 12 Jun 2017 11:20:48 -0500
Subject: [PATCH v4 0/5] Add support for the ARMv8.2 Statistical
 Profiling Extension
In-Reply-To: <20170612110823.GA27319@leverpostej>
References: <1496676177-29356-1-git-send-email-will.deacon@arm.com>
 <20170612110823.GA27319@leverpostej>
Message-ID: <20170612112048.69561e8d067488e8689de755@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jun 2017 12:08:23 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Mon, Jun 05, 2017 at 04:22:52PM +0100, Will Deacon wrote:
> > This is the sixth posting of the patches previously posted here:
> > 
> >   rfcv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html
> >   rfcv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479387.html
> >      v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483684.html
> >      v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499938.html
> >      v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507132.html
> > 
> > The main change since v3 is that I have reworked and fixed the CPU hotplug
> > and notifier bits, in light of review comments from tglx.
> > 
> > The architecture documentation is available here:
> > 
> >   https://developer.arm.com/products/architecture/a-profile/docs/ddi0586/latest/arm-architecture-reference-manual-supplement-statistical-profiling-extension-for-armv8-a
> 
> Kim, do you have any version of the userspace side that we could look
> at?
> 
> For review, it would be really helpful to have something that can poke
> the PMU, even if it's incomplete or lacking polish.

Here's the latest push, based on a a couple of prior versions of this
driver:

http://linux-arm.org/git?p=linux-kp.git;a=shortlog;h=refs/heads/armspev0.1

I don't seem to be able to get any SPE data output after rebasing on
this version of the driver.  Still don't know why at the moment...

Kim

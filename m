From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 07 Mar 2014 20:40:21 +0800
Subject: [PATCH] MAINTAINERS: add maintainers for arm64 acpi
In-Reply-To: <20140304235044.GB11418@arm.com>
References: <1393899345-7397-1-git-send-email-graeme.gregory@linaro.org> <
 1393899345-7397-2-git-send-email-graeme.gregory@linaro.org> <20140304102316
 .GG30596@arm.com> <20140304190318.GE28736@xora-yoga13> <20140304235044.
 GB11418@arm.com>
Message-ID: <20140307124021.BB567C40928@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 4 Mar 2014 23:50:44 +0000, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Tue, Mar 04, 2014 at 07:03:18PM +0000, Graeme Gregory wrote:
> > On Tue, Mar 04, 2014 at 10:23:16AM +0000, Catalin Marinas wrote:
> > > On Tue, Mar 04, 2014 at 02:15:45AM +0000, Graeme Gregory wrote:
> > > > +ACPI ARM64
> > > 
> > > That's a pretty broad statement for a single file. Is it core support,
> > > architected peripherals, SoC?
> > > 
> > Hi Catalin would changing the title to ACPI ARM64 Core Support be better
> > in your mind. I do intend for the maintainership to cover just the
> > plat/arm-core.c file.
> 
> See my reply to Grant. If that's the only thing you guys are aiming for,
> who's in charge of the other bits? Face-to-face meeting in 3 hours
> anyway, so we can get back here with the conclusion.

Update for the benefit of those who weren't at Connect. I really think
Hanjun and Graeme can do an excellent job here, but I appreciate that
they are new to maintainership. To help them along, I'll mentor them in
the maintainer process. I'm encouraging them to take the lead, but I'll
be reading all the patches and I'll jump into the conversation if I
think it is going off the rails. I'll also ack patches when I think they
are in good shape and there is it is well defined what the boundaries
need to be.

We all agree that the current patches are not ready to be merged and
there is feedback to be addressed before the next merge request. We will
not attempt to merge without acks from Catalin.

Also missing is a clear statement of how ACPI works on ARM. There needs
to be a straight forward description of how ACPI PM works and how it is
different from using FDT. That document will be written in short
order and posted for review.

g.

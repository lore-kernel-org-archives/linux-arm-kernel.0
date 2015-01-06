From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Jan 2015 11:53:28 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <20150105205227.GA24657@amd>
References: <548F9668.6080900@linaro.org>
 <20150105205227.GA24657@amd>
Message-ID: <20150106115328.GC8829@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 05, 2015 at 08:52:27PM +0000, Pavel Machek wrote:
> > Back in September 2014, a meeting was held at Linaro Connect where we
> > discussed what issues remained before the arm64 ACPI core patches could
> > be merged into the kernel, creating the TODO list below.  I should have
> > published this list sooner; I got focused on trying to resolve some of
> > the issues instead.
> > 
> > We have made some progress on all of these items.  But, I want to make
> > sure we haven't missed something.  Since this list was compiled by only
> > the people in the room at Connect, it is probable we have.  I, for one,
> > do not yet claim omniscience.
> > 
> > So, I want to ask the ARM and ACPI communities:
> > 
> >   -- Is this list correct?
> > 
> >   -- Is this list complete?
> 
> I'm not sure this is how kernel development works. Expect new issues
> to be raised as patches are being reviewed.

The problem with ACPI is not just the core patches but the entire
hardware/firmware/kernel ecosystem and their interaction, which cannot
always be captured in Linux patches (e.g. firmware test suite, LuvOS,
_DSD properties review process, hardware standardisation).

The above is a to-do list that we raised last year. Of course, new
issues will appear, that's just some items where we can say (for the
time being) that the situation got to an acceptable state once
implemented.

> > 7. Why is ACPI required?
> >    * Problem:
> >      * arm64 maintainers still haven't been convinced that ACPI is
> >        necessary.
> >      * Why do hardware and OS vendors say ACPI is required?
> >    * Status: Al & Grant collecting statements from OEMs to be posted
> >      publicly early in the new year; firmware summit for broader
> >      discussion planned.
> 
> This should be #1 really, right? I still hope the answer is "ACPI not
> needed".

I lost this hope some time ago ;).

>From my perspective, the "why" above still needs to be publicly stated;
there have been several private discussions on the pros and cons and
some of them cannot be made in the open. My main concern is no longer
"why" but "how" to do it properly (and if we can't, we should rather not
do it at all).

-- 
Catalin

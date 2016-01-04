From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jan 2016 11:11:02 +0000
Subject: [PATCH v6] arm/arm64: add arm-smccc
In-Reply-To: <20160104101323.GA24963@red-moon>
References: <1449667495-23091-1-git-send-email-jens.wiklander@linaro.org>
 <20151221111455.GA11145@red-moon> <20151222094606.GA30272@ermac>
 <20151222121449.GE8644@n2100.arm.linux.org.uk>
 <20160104101323.GA24963@red-moon>
Message-ID: <20160104111102.GA19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 10:13:39AM +0000, Lorenzo Pieralisi wrote:
> Hi Russell,
> 
> On Tue, Dec 22, 2015 at 12:14:49PM +0000, Russell King - ARM Linux wrote:
> > Okay, I think as we don't have a decision on this, the proximity of
> > Christmas, and the presumable opening of the merge window early in
> > the new year, I can't merge these patches for the upcoming window.
> > I'll discard those which have already been submitted to the patch
> > system.
> > 
> > This also has a knock-on effect on patch 8486/1:
> > 
> > "ARM64: kernel: PSCI: move PSCI idle management code to drivers/firmware"
> > 
> > which is based on top of this series.  If someone wants to replace
> > that patch with one which has been tested _without_ this series
> > then I'll look at applying it, provided its only trivially different
> > from the existing one.
> 
> I guess Jens' patches are not considered material for the upcoming merge
> window, would you consider applying an updated version of 8486/1 (that does
> not depend on Jens' series) or it is too late ? That patch has already
> missed a merge window for patch dependencies, I would avoid another one,
> I appreciate the timing is not ideal though, please let me know.

The reason I said what I did above was to head-off the merge window
opening last night, and having a rushed job dealing with problems
with patches merged at the last minute.

Consider that the period 24th December to 3rd January does not exist
for many as far as working on the kernel is concerned, and linux-next
probably wasn't running over that period either.

The situation has changed though; last night, Linus released -rc8,
which means we have one week of breathing space before the merge window
is likely to open, and we have four days of linux-next trees.

This means that I'm willing to take patches today (and today only), as
it will give the remainder of the week (up to Thursday - due to the
linux-next timing) to sort out any deficiencies in those patches.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 08:58:14 -0800
Subject: [PATCH 00/13] arm-cci: PMU driver updates for 4.6
In-Reply-To: <56CC64E7.3040407@arm.com>
References: <1456224595-3282-1-git-send-email-suzuki.poulose@arm.com>
 <20160223114003.GF3966@arm.com> <56CC64E7.3040407@arm.com>
Message-ID: <20160224165814.GA10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 01:55:51PM +0000, Suzuki K. Poulose wrote:
> On 23/02/16 11:40, Will Deacon wrote:
> >On Tue, Feb 23, 2016 at 10:49:42AM +0000, Suzuki K Poulose wrote:
> >>Here are some fixes and updates for arm-cci pmu driver targeting v4.6,
> >>applies on top of v4.5-rc5.
> >>
> >>Highlights include :
> >>  - Support for CoreLink CCI-550 PMU
> >>  - Reliable writes to PMU Counter registers for CCI-500/550.
> >>
> >>All the patches have been Acked. Please let me know how this
> >>can be merged.
> 
> >>
> >>  Documentation/devicetree/bindings/arm/cci.txt |    2 +
> >>  drivers/bus/Kconfig                           |   10 +-
> >>  drivers/bus/arm-cci.c                         |  612 +++++++++++++++++--------
> >>  3 files changed, 427 insertions(+), 197 deletions(-)
> >
> >How do you plan to merge this? I can take it all onto a branch for
> >arm-soc, or I can include it on my perf/updates branch, or ...?
> 
> Arnd, Olof,
> 
> What do you think would be the best route ?

Traditionally we've been picking these up in arm-soc in our drivers branch.

Will, unless you want them in your tree for some reason that's what I'll do
here as well.


-Olof

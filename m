From: robert.richter@cavium.com (Robert Richter)
Date: Wed, 21 Jun 2017 15:10:16 +0200
Subject: [PATCH V17 00/11] Add UEFI 2.6 and ACPI 6.1 updates for RAS on
 ARM64
In-Reply-To: <20170621130025.GD16981@rric.localdomain>
References: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
 <20170607115012.GZ30263@arm.com>
 <20170620063439.GS658@rric.localdomain>
 <20170620084931.GB30664@arm.com>
 <20170621130025.GD16981@rric.localdomain>
Message-ID: <20170621131016.GE16981@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.06.17 15:00:25, Robert Richter wrote:
> On 20.06.17 09:49:32, Will Deacon wrote:
> > Hi Robert,
> > 
> > On Tue, Jun 20, 2017 at 08:34:39AM +0200, Robert Richter wrote:
> > > On 07.06.17 12:50:12, Will Deacon wrote:
> > > 
> > > > Thanks, I've pushed this out as:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/ras-apei
> > > >
> > > > which I'll merge into for-next/core (and therefore linux-next) either the
> > > > end of this week or the beginning of next week. Please take a look if you
> > > > get a chance.
> > > 
> > > any reason why there was a roll back of for-next/core?
> > > 
> > >  + 0870f692c2ed...e27c7fa015d6 for-next/core -> arm64/for-next/core  (forced update)
> > > 
> > > Is it because for-next/ras-apei goes through tip?
> > 
> > No, it's because the RAS stuff ran into horrible conflicts with the UUID
> > tree:
> > 
> > https://lkml.org/lkml/2017/6/16/22
> > 
> > Tyler should be rebasing that soon, so hopefully I can requeue that stuff
> > this week.
> 
> Note there are also conflicts with tip-ras from Borsis' tree.

Turned out this is actually the ras/core branch from tip tree, esp.

 https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=7bf130e4a065

-Robert

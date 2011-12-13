From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Dec 2011 18:50:52 -0500 (EST)
Subject: Git pull request: update to the Marvell Orion SOC family
In-Reply-To: <alpine.LFD.2.02.1112131746280.2907@xanadu.home>
References: <alpine.LFD.2.02.1112131611320.2907@xanadu.home>
 <CAOesGMhMgj__0zLk=JrA3d6+x4gZFfBbN0eO7wnge7tLsLOsqg@mail.gmail.com>
 <alpine.LFD.2.02.1112131746280.2907@xanadu.home>
Message-ID: <alpine.LFD.2.02.1112131848190.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Dec 2011, Nicolas Pitre wrote:

> On Tue, 13 Dec 2011, Olof Johansson wrote:
> 
> > Hi Nico (and Andrew),
> > 
> > On Tue, Dec 13, 2011 at 1:18 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > 
> > > This contains minor fixes plus initial consolidation toward DT support.
> > >
> > >
> > > Andrew Lunn (4):
> > > ? ? ?Consolidate the address map setup on Orion based platforms.
> > > ? ? ?Move the *_mbus_dram_info structure into the orion platform and call it orion_mbus_dram_info everywhere.
> > > ? ? ?Get address map from plat-orion instead of via platform_data.
> > > ? ? ?Remove address map info from all platform data strucutures.
> > 
> > Andrew, in the future please prefix the patch subject with the
> > subsystem/platform. One of them has a really long subject too.
> > 
> > Nico: The last two patches in the branch have your Acked-by but not a
> > Signed-off-by, even though you were the committer. Would you mind
> > fixing that and sending a new request, please?
> 
> OK, hold on I'll fix both issues.

Olof, please re-pull.  Here's the amended shortlog:

Andrew Lunn (4):
      ARM: Orion: Consolidate the address map setup
      ARM: Orion: mbus_dram_info consolidation
      ARM: Orion: Get address map from plat-orion instead of via platform_data
      ARM: Orion: Remove address map info from all platform data structures

Arnaud Patard (1):
      ARM: Kirkwood: Add configuration for MPP12 as GPIO

Martin Michlmayr (1):
      ARM: Kirkwood: Recognize A1 revision of 6282 chip


Nicolas

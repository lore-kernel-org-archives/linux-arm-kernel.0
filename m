From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 14:41:35 +0200
Subject: [PATCH 00/03] ARM: 64-bit memory fixes, APE6EVM second memory bank
In-Reply-To: <CANqRtoSZXz5-z4pMTM_gpTf11qQCc870Vf35qLQ4jpoCPnq4KQ@mail.gmail.com>
References: <20130605104427.1720.68752.sendpatchset@w520>
 <201306051317.02284.arnd@arndb.de>
 <CANqRtoSZXz5-z4pMTM_gpTf11qQCc870Vf35qLQ4jpoCPnq4KQ@mail.gmail.com>
Message-ID: <201306121441.35924.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Magnus Damm wrote:
> On Wed, Jun 5, 2013 at 8:17 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 05 June 2013, Magnus Damm wrote:
> >> ARM: 64-bit memory fixes, APE6EVM second memory bank
> >>
> >> [PATCH 01/03] ARM: Let arm_add_memory() always use 64-bit arguments
> >> [PATCH 02/03] ARM: Handle 64-bit memory in case of 32-bit phys_addr_t
> >> [PATCH 03/03] ARM: shmobile: Add second memory bank to DTS for APE6EVM
> >>
> >> This patch set contains two fixes and one mach-shmobile specific patch
> >> to add a second memory bank. The fixes attempt to improve the memory bank
> >> handling in the ARM kernel in case of 64-bit addresses.
> >
> > Please have a look at this patch that Stepan Moskovchenko posted:
> >
> > https://patchwork.kernel.org/patch/2639171/
> >
> > I think we are going to need only one of the two approaches.
> 
> Thanks for pointing out this implementation. Is there anything I can
> do to move this forward?

I'm fine with either solution. If Russell doesn't have a preference
one way or the other, I'd suggest you agree with Stepan on one of the
two and put that into the patch tracker.

	Arnd

From: olof@lixom.net (Olof Johansson)
Date: Tue, 17 Jan 2017 12:11:12 -0800
Subject: [GIT PULL] Amlogic fixes for v4.10-rc4
In-Reply-To: <m2wpdt4qll.fsf@baylibre.com>
References: <m2inpi6d09.fsf@baylibre.com>
 <c781a080-455f-bba2-1bfb-cdd39343842b@suse.de>
 <20170117060414.GD16607@localhost> <m2wpdt4qll.fsf@baylibre.com>
Message-ID: <20170117201112.GA15508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 08:07:50AM -0800, Kevin Hilman wrote:
> Hi Olof,
> 
> Olof Johansson <olof@lixom.net> writes:
> 
> > On Mon, Jan 16, 2017 at 03:24:59PM +0100, Andreas F??rber wrote:
> >> Am 13.01.2017 um 19:17 schrieb Kevin Hilman:
> >> > ----------------------------------------------------------------
> >> > Amlogic fixes for v4.10-rc4
> >> > - odroid-c2: disable DVFS to avoid crashes due to broken SCPI
> >> > - fix misc. crashes by adding known reserved memory regions
> >> > 
> >> > ----------------------------------------------------------------
> >> > Neil Armstrong (2):
> >> >       ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
> >> 
> >> >       ARM64: dts: meson-gx: Add reserved memory zone and usable memory range
> >> 
> >> Objection against the latter patch introducing widespread usage of
> >> hardcoded linux,usable-memory properties - please review closely before
> >> considering to merge.
> >
> > Holding off until that discussion has concluded. Following up on that thread as
> > well.
> 
> While we rework the reserved memory fix, could you cherry-pick the SCPI
> fix from this branch into fixes?  That one is independent from this, and
> is also a nasty crash.

Sure! Applied to fixes.


Thanks,

-Olof

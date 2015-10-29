From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 29 Oct 2015 09:44:59 +0000
Subject: [GIT PULL] arm64: Juno: Add support for PCIe or R1 board
In-Reply-To: <7hh9lajahx.fsf@deeprootsystems.com>
References: <20151021113629.GF3394@e106497-lin.cambridge.arm.com>
 <4136958.Qhq5GfeeVa@wuerfel>
 <20151026101256.GF963@e106497-lin.cambridge.arm.com>
 <20151026235505.GA13221@localhost>
 <20151027101218.GI963@e106497-lin.cambridge.arm.com>
 <7hh9lajahx.fsf@deeprootsystems.com>
Message-ID: <20151029094459.GN963@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 02:21:30AM -0700, Kevin Hilman wrote:
> Liviu Dudau <Liviu.Dudau@arm.com> writes:
> 
> > On Tue, Oct 27, 2015 at 08:55:05AM +0900, Olof Johansson wrote:
> >> Hi,
> >> 
> >> On Mon, Oct 26, 2015 at 10:12:57AM +0000, Liviu Dudau wrote:
> >> > On Fri, Oct 23, 2015 at 10:42:53PM +0200, Arnd Bergmann wrote:
> >> > > On Wednesday 21 October 2015 12:36:29 Liviu Dudau wrote:
> >> > > > The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ade622:
> >> > > > 
> >> > > >   Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)
> >> > > > 
> >> > > > are available in the git repository at:
> >> > > > 
> >> > > > 
> >> > > 
> >> > > Not pulled.
> >> > > 
> >> > > All our branches are based on -rc4 or earlier, and we'd like to avoid
> >> > > backmerges from mainline if at all possible.
> >> > > 
> >> > > Can you rebase this to -rc4 and send again?
> >> > > 
> >> > > 	Arnd
> >> > 
> >> > Sure, I've rebased the branch on top of -rc4 now, so here is the new request.
> >> > 
> >> > Many thanks,
> >> > Liviu
> >> > 
> >> > The following changes since commit 049e6dde7e57f0054fdc49102e7ef4830c698b46:
> >> > 
> >> >   Linux 4.3-rc4 (2015-10-04 16:57:17 +0100)
> >> > 
> >> > are available in the git repository at:
> >> > 
> >> >   git://linux-arm.org/linux-ld for-upstream/juno-pcie
> >> 
> >> This is showing up late by now, but Juno also isn't a high-volume platform
> >> so exposure to regressions are limited.
> >> 
> >> That being said, I really hope we won't have to pick up any fixes for
> >> this due to lack of exposure to -next after the merge window.
> >> 
> >> 
> >> Merged into next/arm64.
> >
> > Thanks,
> >
> > The PCIe setup has been tested pretty thoroughly (famous last words) inside ARM.
> > The only surprises can come from various combinations of bootloaders and the
> > kernel, and I'm happy to handle those.
> >
> 
> FWIW, I've also been testing PCIe on juno-r1.  Unfortunately, it
> currently only works with the UEFI loader, but I understand PCIe init is
> on it's way upstream in mainline u-boo also, but I haven't been able to
> test that yet.

Tom Rini was kind enough to pull the changes before 2015.10 was cut out, so mainline
U-Boot works fine, that is what I'm using at the moment.

Best regards,
Liviu

> 
> Kevin
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?

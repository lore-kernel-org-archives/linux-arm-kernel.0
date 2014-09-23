From: olof@lixom.net (Olof Johansson)
Date: Mon, 22 Sep 2014 21:51:57 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v3.17
In-Reply-To: <20140914083423.GV21986@titan.lakedaemon.net>
References: <20140914083423.GV21986@titan.lakedaemon.net>
Message-ID: <20140923045157.GB7487@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 04:34:23AM -0400, Jason Cooper wrote:
> oops, resend to include the arm alias.  sorry.
> 
> Guys,
> 
> Here's everything we've collected so far wrt mvebu.  I don't see
> anything else on the horizon atm.  These have been in -next for a while.
> 
> Please pull.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> 
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.17
> 
> for you to fetch changes up to ace8578182dc347b043c0825b9873f62fdaa5b77:
> 
>   ARM: mvebu: Netgear RN102: Use Hardware BCH ECC (2014-09-14 04:17:13 +0000)
> 
> ----------------------------------------------------------------
> mvebu fixes for v3.17
> 
>  - kirkwood
>     - final driver cleanup of ARCH_KIRKWOOD removal
>     - fix DT based DSA
> 
>  - mvebu
>     - use BCH ECC for the RN2120 and RN104/2 nand chips
> 
> ----------------------------------------------------------------
> Andrew Lunn (8):
>       cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
>       ata: Remove ARCH_KIRKWOOD dependency
>       thermal: Remove ARCH_KIRKWOOD dependency
>       leds: Remove ARCH_KIRKWOOD dependency
>       rtc: Remove ARCH_KIRKWOOD dependency
>       watchdog: Remove ARCH_KIRKWOOD dependency
>       cpufreq: Remove ARCH_KIRKWOOD dependency
>       ARM: Kirkwood: Fix DT based DSA.
> 
> Arnaud Ebalard (2):
>       ARM: mvebu: Netgear RN104: Use Hardware BCH ECC
>       ARM: mvebu: Netgear RN2120: Use Hardware BCH ECC
> 
> klightspeed at killerwolves.net (1):
>       ARM: mvebu: Netgear RN102: Use Hardware BCH ECC

Hi,

We've been dragging pull requests for a while (we've both been
busy). However, we're past possibly the last -rc and need to crank down
in what we consider a fix to be.

Are any of these strictly required for 3.17 or should I just queue them
for 3.18 at this point? "Fix DT based DSA" seems from the description
like it might be the sole 3.17 candidate?


-Olof

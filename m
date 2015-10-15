From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 20:53:17 +0200
Subject: [GIT PULL] ARM: berlin: DT CPU clock fixup for v4.4
In-Reply-To: <1444934667-5451-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1444416494-3117-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <1444934667-5451-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5158506.pFES6Vjd9X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 20:44:27 Sebastian Hesselbarth wrote:
> Arnd, Kevin, Olof,
> 
> this is the single patch PR to fix the broken DT PR for Berlin
> sent earlier. As Arnd requested, this only contains a patch adding
> the missing CPUID_CLK to Berlin clock dt-binding include.
> 
> Please pull.
> 
> Sebastian
> 
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-dt-cpuclk-for-4.4-1
> 
> for you to fetch changes up to 28c039eebaaa28def9364b9a12a30192be8b4730:
> 
>   ARM: berlin: dts: add CLKID_CPU for BG2Q (2015-10-15 20:31:41 +0200)
> 
> ----------------------------------------------------------------
> Marvell Berlin DT CPU clock for 4.4
> - add missing CLKID_CPU for Berlin BG2Q
> 

Pulled into next/dt, thanks a lot for the fix!

	Arnd

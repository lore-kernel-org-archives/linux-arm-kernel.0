From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 16:59:50 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v3.9 (round 3)
In-Reply-To: <20130410171254.GD28693@titan.lakedaemon.net>
References: <20130410171254.GD28693@titan.lakedaemon.net>
Message-ID: <201304111659.50770.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 April 2013, Jason Cooper wrote:
> 
> The following changes since commit 879d68a445dd7073a8c022fcdd21dc27eca7f192:
> 
>   arm: mvebu: Fix pinctrl for Armada 370 Mirabox SDIO port. (2013-03-28 17:29:23 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/mvebu_fixes_for_v3.9_round3
> 
> for you to fetch changes up to 600468d0686096ddc1000c8a2e69475931084414:
> 
>   arm: mvebu: Fix the irq map function in SMP mode (2013-04-10 16:59:14 +0000)
> 
> ----------------------------------------------------------------
> mvebu fixes for v3.9 round 3
> 
>  - Kirkwood
>     - a couple of small fixes for the Iomega ix2-200 board (ether and led)
>  - mvebu
>     - allow GPIO button to work on Mirabox when running SMP

Pulled into the fixes branch. I'll try to get a pull request out to Linus today,
since we already have a few other patches pending.

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 7 May 2015 18:23:30 +0200
Subject: [GIT PULL] pxa fixes for v4.1
In-Reply-To: <87r3r0jzge.fsf@belgarion.home>
References: <87r3r0jzge.fsf@belgarion.home>
Message-ID: <201505071823.30533.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 May 2015, Robert Jarzmik wrote:
> Hello Arnd, Kevin, Olof,
> 
> Please consider this pull request for pxa, repairing lubbock and mainstone.
> 
> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
> 
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/rjarzmik/linux.git tags/fixes-for-v4.1-rc2
> 
> for you to fetch changes up to fc9e38c0f4d38bfc68b405cf48365d65f7b6319e:
> 
>   ARM: pxa: lubbock: use new pxa_cplds driver (2015-04-30 22:52:51 +0200)
> 
> ----------------------------------------------------------------
> ARM: pxa: fixes for v4.1-rc2
> 
> These fixes reenable the lubbock(pxa25x) and mainstone(pxa27x)
> platforms, which were broken since the gpio handling was
> converted to a driver, and the interrupt ordering broke the
> external interrupts of these systems.

Pulled into fixes branch, thanks!

	Arnd

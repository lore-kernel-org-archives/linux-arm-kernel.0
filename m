From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 Feb 2012 14:09:52 +0000
Subject: [GIT PULL] LPC32xx fixes for v3.3-rc4
In-Reply-To: <4F490CC0.5050303@antcom.de>
References: <4F490CC0.5050303@antcom.de>
Message-ID: <201202271409.52470.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 February 2012, Roland Stigge wrote:
> the fixes for LPC32xx that I just posted as patches are also available as a
> git branch to pull from as described below.
> 
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
> 
>   Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
> 
> are available in the git repository at:
> 
>   git://git.antcom.de/linux-2.6.git lpc32xx-fixes
> 
> for you to fetch changes up to 3eddb16b7b275162c62f67bb75cc6bbe0ef8c075:
> 
>   ARM: LPC32xx: serial.c: Fixed loop limit (2012-02-25 16:32:44 +0100)

Hi Roland,

The patch look all good, but it's not clear where you would like to
see them applied. The largest one "ARM: LPC32xx: Fix missing and bad
LPC32XX macros" looks like it is only of cosmetic nature and should
go into the next/fixes-non-critical branch for v3.4, while the
others look like they are requried for v3.3, some of them
also for earlier versions. Remember that any bug fix that applies
to older kernels should have a "Cc: stable at vger.kernel.org" tag
so that Greg can automatically pick up the fixes and port them
to the stable and longterm releases.

	Arnd

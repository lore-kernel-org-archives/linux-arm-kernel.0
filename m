From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Apr 2016 23:29:10 +0200
Subject: [GIT PULL 2/3] ARM: tegra: Changes for v4.7-rc1
In-Reply-To: <1460731323-31001-2-git-send-email-thierry.reding@gmail.com>
References: <1460731323-31001-1-git-send-email-thierry.reding@gmail.com>
 <1460731323-31001-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <8017890.92B3ctfOGM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 16:42:02 Thierry Reding wrote:
> ARM: tegra: Changes for v4.7-rc1
> 
> A couple of patches that cleanup some Kconfig, enable various features,
> use stdout-path to define the debug serial port (so that it doesn't have
> to be manually specified on the kernel command-line) and cleanup and fix
> some minor device trees bugs.

I'd rather have seen the Kconfig changes in a separate branch, or mixed
in with the PULL 1/3, but it's not important enough to ask for a respin.

Pulled into next/dt, thanks!

	Arnd

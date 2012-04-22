From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 Apr 2012 20:32:48 +0000
Subject: [GIT PULL] at91: fist cleanup branch for 3.5
In-Reply-To: <4F8D9037.9010401@atmel.com>
References: <4F8D9037.9010401@atmel.com>
Message-ID: <201204222032.48694.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 April 2012, Nicolas Ferre wrote:
> Arnd, Olof,
> 
> The following changes since commit e816b57a337ea3b755de72bec38c10c864f23015:
> 
>   Linux 3.4-rc3 (2012-04-15 18:28:29 -0700)   
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-3.5-cleanup
> 
> for you to fetch changes up to 39ecc143b4c1f3d42e8300e7f5274681b99f95c2:
> 
>   ARM: at91: add defconfig for device tree (2012-04-17 14:47:22 +0200)
> 
> ----------------------------------------------------------------
> First batch of AT91 cleanup for 3.5 kernel.
> - The biggest improvement of this series is the ability to compile several
>   AT91 SoCs in one kernel image.
>   For now on it's limited to the DT-enabled boards but we can compile all
>   the core together.
> - The Kconfig series is stacked before other patches as it is simple and
>   non-intrusive. Its goal is to remove too restrictive dependencies on
>   SoC names. This will allow to add support for newer SoC seamlessly.
> - Some very "cosmetic" Kconfig changes are also added (entry names,
>   comments, etc.).

Pulled into the next/cleanup branch, and also pulled the MAINTAINERS
update into the next/maintainers branch.

Olof, this is the first pull from a tag I've done, and I think we
should decide on a method to show these pulls in the log. I've
set the at91/cleanup branch to the version that Nicolas sent,
without the merge changeset that is normally generated when you
pull from a tag. For next/cleanup branch, I've pulled directly from
the tag and edited the commit message a bit. Do you think that's good
or do you know a better way to handle these?

	Arnd

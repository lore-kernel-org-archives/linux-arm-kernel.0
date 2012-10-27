From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 27 Oct 2012 18:42:04 +0530
Subject: [PATCH] ARM: OMAP4: Basic default configuration for Pandaboard
In-Reply-To: <1351339406-10082-1-git-send-email-const@MakeLinux.com>
References: <1351339406-10082-1-git-send-email-const@MakeLinux.com>
Message-ID: <508BDDA4.6050208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 October 2012 05:33 PM, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
>
> Tested SD (MMC) and Ethernet smsc95xx on linux-3.7-rc2
>
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
> --
> kernel size is 2.3 MiB
> ---
>   arch/arm/configs/omap4_panda_defconfig |  115 ++++++++++++++++++++++++++++++++

We got rid of all omap board defconfigs and now just using
omap2plus_defconfig for all OMAP2/3/4/5 machines. If something
is missing from omap2plus_defconfig, which you need to on your
panda custom config, do send patch for that. Otherwise, we are
no longer adding board defconfigs.

Regards
Santosh

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:08:54 +0100
Subject: [GIT PULL 4/6] i.MX device tree updates for 4.17
In-Reply-To: <1521113800-16401-4-git-send-email-shawnguo@kernel.org>
References: <1521113800-16401-1-git-send-email-shawnguo@kernel.org>
 <1521113800-16401-4-git-send-email-shawnguo@kernel.org>
Message-ID: <CAK8P3a3NXL_0z+Qm1O5Giz3SstGeHd1ghB320b6OSZPOeY1uuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 12:36 PM, Shawn Guo <shawnguo@kernel.org> wrote:
> The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:
>
>   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.17
>
> for you to fetch changes up to f4be9b77fac3d8141add1d84e75199f0e0ddd5a3:
>
>   ARM: dts: i.MX25: define SSI FIFO depth (2018-03-12 15:23:36 +0800)
>
> ----------------------------------------------------------------
> i.MX device tree updates for 4.17:
>  - New board support: phyBOARD-Mira i.MX6 boards; Advantech DMS-BA16
>    i.MX6Q board; Toradex Colibri iMX6ULL boards.
>  - ZII RDU board updates: add RAVE SP device; disable on-chip watchdog
>    as the external watchdog is being used instead; improve USDHC node
>    regarding to voltage and SDIO capability.
>  - i.MX6UL/ULL updates: cpufreq clock cleanup; add IOMUXC_SNVS pins and
>    missing daisy chain configurations; add more devices like WDOG3,
>    UART8, PMU, architected timer etc.
>  - Hummingboard updates: correct USBOTG-ID pin; remove mention of
>    nonexistent node.
>  - Fix compatibles of atmel eeprom devices.
>  - A couple of improvements on i.MX25 pinfunc header regarding to eSDHC
>    pins.
>  - A bunch of patches from Fabio and Marco to fix DTC warnings seen with
>    W=1 switch.
>  - Remove GPU subsystem nodes, as they are not needed by the etnaviv
>    driver anymore and have been removed from the binding.
>  - Add FIFO depth definition for i.MX25 SSI devices.
>  - Add missing '#sound-dai-cells' for sgtl5000 codec which is complained
>    by DTC.
>  - Miscellaneous and random updates.

Pulled into next/dt, thanks!

       Arnd

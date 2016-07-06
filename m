From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Jul 2016 21:09:51 -0700
Subject: [GIT PULL 3/5] i.MX device tree updates for 4.8
In-Reply-To: <1467117980-20063-3-git-send-email-shawnguo@kernel.org>
References: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
 <1467117980-20063-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20160706040951.GD23212@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2016 at 08:46:18PM +0800, Shawn Guo wrote:
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.8
> 
> for you to fetch changes up to b326629f25b7c1a6d1c63a8c5483c8db11689d9c:
> 
>   ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D support (2016-06-28 10:45:37 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree update for 4.8:
>  - Add two i.MX23/STMP3780 based MP3 player device support, Creative
>    X-Fi3 and SanDisk Sansa Fuze+
>  - Add the support of Auvidea H100 device which is a SolidRun MicroSOM
>    baseboard
>  - Restructure i.MX7Dual DTS files to support i.MX7Solo and add Toradex
>    Colibri iMX7S/iMX7D boards
>  - Device additions and enabling for various boards: mmc device for
>    utilite-pro, IRQ controller and CAN support for TS-4800, display and
>    touchscreen support for imx7d-sdb, SAI audio and LCD support for
>    imx6ul-14x14-evk, gpio power off support for imx6q-bx50v3, etc.
>  - Update the boards from Freescale/NXP to use WDOG_B pin for reset
>  - PCI reset polarity correction for imx6qdl-sabresd and imx6q-tbs2910
>  - Update i.MX board dts files to use generic uart-has-rtscts DT
>    property instead of vendor specific one
>  - DTC warning fixing for a few boards which are mostly mismatch between
>    unit-address and reg property
>  - Remove SION setting from all mux modes on i.MX25

Merged, thanks.


-Olof

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 11:47:03 +0100
Subject: [GIT PULL 1/3] omap device tree changes for v3.19
In-Reply-To: <pull-1415814409-868361>
References: <pull-1415814409-868361>
Message-ID: <201411201147.04064.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Tony Lindgren wrote:
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/dt-part1
> 
> for you to fetch changes up to 065bd7fe50de5e6d0fd5034cbc87120a558a1219:
> 
>   ARM: dts: DRA7: Add aliases for all serial ports (2014-11-12 07:04:37 -0800)
> 
> ----------------------------------------------------------------
> Device tree related changes for omaps:
> 
> - Fix currently harmless but wrong sizes for various GPMC connected
>   devices
> 
> - Set up timings for several GPMC connected devices to get rid of
>   bootloader dependencies in later patches
> 
> - Enable various drivers for dra7xx
> 
> - Prepare Igep boards to support new variants
> 
> - Add intial support for BeagleBoard-X15

pulled into next/dt, thanks!

	Arnd

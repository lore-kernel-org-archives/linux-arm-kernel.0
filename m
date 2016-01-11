From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 14:24:38 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Fixes for v4.5
In-Reply-To: <cover.1452486598.git.horms+renesas@verge.net.au>
References: <cover.1452486598.git.horms+renesas@verge.net.au>
Message-ID: <12158843.NNA1TZZ1Ae@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 January 2016 13:32:51 Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT fixes for v4.5.
> 
> This pull request is based on the
> "Third Round of Renesas ARM Based SoC DT Updates for v4.5",
> tagged as renesas-dt3-for-v4.5, which you have already pulled.
> 
> This adds the required property to partitions nodes for the device trees
> of Renesas ARM Based SoC which have such a node added in patches queued up
> for v4.5.
> 
> The following changes since commit d01c8bec91414f2110370dfcb9dd33fc0e573cee:
> 
>   ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings (2015-12-17 10:10:54 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-fixes-for-v4.5
> 
> for you to fetch changes up to 8bc403b78ffb774d8dc944abb0826c46c0dca09d:
> 
>   ARM: dts: silk: Add compatible property to "partitions" node (2016-01-07 08:39:06 +1100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Fixes for v4.5
> 
> * Add compatible property to "partitions" node
> 
>   As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>   property to "partitions" node"), which is in v4.4-rc6, the "partitions"
>   subnode of an SPI FLASH device node must have a compatible property. The
>   partitions are no longer detected if it is not present.

Pulled into next/dt, thanks!

	Arnd

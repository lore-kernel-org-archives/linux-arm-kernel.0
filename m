From: john@phrozen.org (John Crispin)
Date: Tue, 10 Jan 2017 08:00:16 +0100
Subject: [PATCH 0/4] ARM: dts: mt7623: Add initial Geek Force support
In-Reply-To: <20170108133100.10428-1-afaerber@suse.de>
References: <20170108133100.10428-1-afaerber@suse.de>
Message-ID: <91f5ec74-1aa1-f2ad-24e9-14267cbe8498@phrozen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/01/2017 14:30, Andreas F?rber wrote:
> 
> Andreas F?rber (4):
>   Documentation: devicetree: Add vendor prefix for AsiaRF
>   Documentation: devicetree: arm: mediatek: Add Geek Force board
>   ARM: dts: mt7623: Add Geek Force config
>   MAINTAINERS: Extend ARM/Mediatek SoC support section
> 

Hi,

i need to NAK this series. the asiarf board is nothing more than the
official MTK EVB with AsiaRF written on it. this board is already
supported by linux (arch/arm/boot/dts/mt7623-evb.dts) please extend the
EVB dts file nstead of adding a duplicate and letting the original bitrot.

	John

>  Documentation/devicetree/bindings/arm/mediatek.txt |  3 +
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  MAINTAINERS                                        |  2 +
>  arch/arm/boot/dts/Makefile                         |  1 +
>  arch/arm/boot/dts/mt7623-geekforce.dts             | 77 ++++++++++++++++++++++
>  5 files changed, 84 insertions(+)
>  create mode 100644 arch/arm/boot/dts/mt7623-geekforce.dts
> 

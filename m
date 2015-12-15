From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 17:32:15 +0100
Subject: [PATCH v5 2/2] arm: pxa27x: support for ICP DAS LP-8x4x w/ DT
In-Reply-To: <1450196875-6739-1-git-send-email-ynvich@gmail.com>
References: <1449700088-28076-3-git-send-email-ynvich@gmail.com>
 <1450196875-6739-1-git-send-email-ynvich@gmail.com>
Message-ID: <7496839.vMjVcqPe8Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 December 2015 19:27:50 Sergei Ianovich wrote:
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   3 +
>  arch/arm/boot/dts/pxa27x-lp8x4x-i105.dts           |  50 ++++
>  arch/arm/boot/dts/pxa27x-lp8x4x.dts                | 259 +++++++++++++++++++++
>  arch/arm/configs/lp8x4x_defconfig                  | 176 ++++++++++++++
> 

I had not noticed earlier that you are adding a new defconfig file. PXA is
already the platform with the most defconfig files, and I'd rather like
to see that reduced than increased.

Is there a chance you could merge this one with some of the existing files
into one configuration that handles them all?

	Arnd

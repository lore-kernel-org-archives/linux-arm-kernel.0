From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 07 Jul 2016 10:45:35 -0700
Subject: [GIT PULL] Amlogic DT 64-bit updates for v4.8 (#2)
In-Reply-To: <7025009.icO1nWIe4a@wuerfel> (Arnd Bergmann's message of "Thu, 07
 Jul 2016 17:57:16 +0200")
References: <m237nmqt41.fsf@baylibre.com> <7025009.icO1nWIe4a@wuerfel>
Message-ID: <m2shvlpcjk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday, July 6, 2016 3:50:06 PM CEST Kevin Hilman wrote:
>> 
>> Kevin Hilman (1):
>>      ARM64: DTS: meson-gxbb: switch ethernet to real clock
>
>
> This one caused a build regression since the clk driver is not part of arm-soc:
>
> /work/build/batch/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi:48:41: fatal error: dt-bindings/clock/gxbb-clkc.h: No such file or directory
>
> I assume the patch was not meant to be applied yet and accidentally
> slipped in, I've reverted it for now so we get a clean build with the
> arm-soc tree.

OK, Thanks.

Kevin

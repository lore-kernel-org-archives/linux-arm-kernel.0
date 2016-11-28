From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 28 Nov 2016 12:16:37 -0800
Subject: [PATCH 2/2] Add support for the Nexbox A1 board based on the
 Amlogic S912 SoC.
In-Reply-To: <20161123225205.re77xff5vcccaltl@rob-hp-laptop> (Rob Herring's
 message of "Wed, 23 Nov 2016 16:52:05 -0600")
References: <20161121162905.14285-1-narmstrong@baylibre.com>
 <20161121162905.14285-3-narmstrong@baylibre.com>
 <20161123225205.re77xff5vcccaltl@rob-hp-laptop>
Message-ID: <m24m2rtl5m.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Mon, Nov 21, 2016 at 05:29:05PM +0100, Neil Armstrong wrote:
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
>>  arch/arm64/boot/dts/amlogic/Makefile               |   1 +
>>  .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 169 +++++++++++++++++++++
>>  3 files changed, 171 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
>
> A few nits below, otherwise:
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Fixed up the changes locally, and applied for v4.10.

Kevin

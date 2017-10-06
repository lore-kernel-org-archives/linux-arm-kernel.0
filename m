From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 15:38:13 -0700
Subject: [PATCH 0/3] soc: amlogic: Add Meson6/8/8b SoC Information driver
In-Reply-To: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sat, 23 Sep 2017 16:14:00 +0200")
References: <20170923141403.20882-1-martin.blumenstingl@googlemail.com>
Message-ID: <7h60br9a22.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> The 32-bit Amlogic SoC have some registers which contain some information
> the SoC's major and version, as well as a "major version".
> This patchset adds support for this register decoding and exposing with the
> SoC bus infrastructure, with dt-bindings and DT node.
>
> This is inspired by Neil's Meson GX socinfo driver, see [0]
>
> All information was taken from Amlogic's 3.10 GPL kernel sources because
> the public S805 datasheet from Hardkernel does not contain any relevant
> information for these register blocks.
>
>
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2017-June/004187.html
>
> Martin Blumenstingl (3):
>   dt-bindings: Amlogic: add documentation for the SoC info register
>     areas

Applied to v4.15/dt

>   soc: amlogic: Add Meson6/Meson8/Meson8b/Meson8m2 SoC Information
>     driver

Applied to v4.15/drivers

>   ARM: dts: meson: add SoC information nodes

Applied to v4.15/dt

Thanks,

Kevin

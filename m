From: julian.calaby@gmail.com (Julian Calaby)
Date: Sat, 3 Feb 2018 17:45:52 +1100
Subject: [linux-sunxi] [PATCH v3] ARM: sun8i: h2+: add support for Banana
 Pi M2 Zero board
In-Reply-To: <20171224054029.12278-1-icenowy@aosc.io>
References: <20171224054029.12278-1-icenowy@aosc.io>
Message-ID: <CAGRGNgXRhphuO8+85t8vfQb2CxDekMXe2BoPo_57pc6SR3QQzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Sun, Dec 24, 2017 at 4:40 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Banana Pi M2 Zero board is a H2+-based board by Sinovoip, with a form
> factor and GPIO holes similar to Raspberry Pi Zero.
>
> It features:
> - Allwinner H2+ SoC
> - Single-chip (16-bit) 512MiB DDR3 DRAM
> - Ampak AP6212 Wi-Fi/Bluetooth module
> - MicroSD slot
> - Two MicroUSB Type-B ports (one can only be used to power the board and
>   the other features OTG functionality)
> - Two keys, a reset and a GPIO-connected key.
> - HDMI Type-C (miniHDMI) connector connected to the HDMI part of H2+.
> - CSI connector to connect the camera sensor provided by Sinovoip.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

[Trimmed lots of non-sunxi-specific mailing lists]

Did support for this board ever get merged?

(I have two of them now, so if it didn't, I'll try to shepherd this
and it's corresponding u-boot patch upstream.)

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

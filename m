From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 16:05:01 -0700
Subject: [PATCH v2 0/2] ARM64: meson-gxm: Add support for Khadas VIM2
In-Reply-To: <1507044283-18476-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Tue, 3 Oct 2017 17:24:41 +0200")
References: <1507044283-18476-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hwp477u8y.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The Khadas VIM2 is a Single Board Computer, respin of the origin
> Khadas VIM board, using an Amlogic S912 SoC and more server oriented.
>     
> It provides the same external connectors and header pinout, plus a SPI
> NOR Flash, a reprogrammable STM8S003 MCU, FPC Connector, Cooling FAN header
> and Pogo Pads Arrays.
>
> To eventually provide access to the SPI NOR flash, the eMMC DS pin must be
> configured as a different pincrl node to disable it's access from the MMC
> Controller. This first patch splits this emmc pins entry for GXBB and GXL.
>
> Depends on eMMC ARM64 DT patches from Jerome Brunet at [2]

eMMC patches now merged in mainline, so Appled to v4.15/dt64 with
Jerome's Tested-by,

Kevin

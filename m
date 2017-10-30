From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 30 Oct 2017 09:27:59 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: fix usb1 power supply
In-Reply-To: <1508409069-6317-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Thu, 19 Oct 2017 12:31:09 +0200")
References: <1508409069-6317-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <7hshe1ujjk.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Looking at the schematics, the USB Power Supply is shared between the
> two USB interfaces,
> If the usb0 fails to initialize, the second one won't have power.
>
> Fixes: 5a0803bd5ae2 ("ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.15/dt64,

Kevin

From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 19 Oct 2017 12:18:22 +0200
Subject: [PATCH 0/2] Introduce new DT files for Meson-AXG SoC
In-Reply-To: <20171013231313.22850-1-dlan@gentoo.org> (Yixun Lan's message of
 "Sat, 14 Oct 2017 07:13:11 +0800")
References: <20171013231313.22850-1-dlan@gentoo.org>
Message-ID: <7hfuafzbip.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <dlan@gentoo.org> writes:

> This attempt will try to add new DT files to support Meson-AXG SoC.
> Due to the AXG series has new memory layout, we decide to start a new
> DT structure without sharing with previous meson-gx.dtsi
>
> 1) in the first patch, we try to document the new Meson-AXG bindings
> 2) in the second patch, we try to bring up a minimal serial console,
> so it's capable of running a minimal system (in ramdisk).
>
> Yixun Lan (2):
>   dt-bindings: arm: amlogic: Add Meson AXG binding
>   arm64: dts: meson-axg: add initial A113D SoC DT support

Applied to v4.15/dt64 with reviews and acks.

Kevin

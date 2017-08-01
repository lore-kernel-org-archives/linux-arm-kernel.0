From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 01 Aug 2017 12:56:07 -0700
Subject: [PATCH 1/2] ARM64: dts: meson-gxl-khadas-vim: Add GPIO lines names
In-Reply-To: <1501250084-19967-2-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 28 Jul 2017 15:54:43 +0200")
References: <1501250084-19967-1-git-send-email-narmstrong@baylibre.com>
 <1501250084-19967-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <7htw1rxdt4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This patch describes the GPIO lines usage on the Khadas VIM board.
>
> This is useful in the debugfs gpio file and using the cdev gpio API.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

[...]

> +			  /* Bank BOOT */
> +			  "eMMC D0", "eMMC D1", "eMMC D2", "eMMC D3",
> +			  "eMMC D4", "eMMC D5", "eMMC D6", "eMMC D7",
> +			  "eMMC Clk", "eMMC Reset", "eMMC CMD",
> +			  "", "BOOT_MODE", "", "", "eMMC Data Strobe", 

nit/FYI: checkpatch whined about some trailing whitespace here.  I fixed up
locally before applying to v4.14/dt64.

Kevin

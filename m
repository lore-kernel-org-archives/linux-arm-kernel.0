From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 26 Sep 2018 11:08:18 +0200
Subject: [PATCH v5 0/2] arm64: dts: meson-g12a: Introduce new DT files for
 Meson-G12A SoC
In-Reply-To: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
 (Jianxin Pan's message of "Fri, 21 Sep 2018 16:34:39 +0800")
References: <1537518881-53137-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <7hzhw44oe5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> This attempt will try to add new DT files to support Meson-G12A SoC.
>
> 1) first, Please notice that, in this patch series, the DT node about 16M reserved
> memory for hwrom is removed, since it's not needed by G12A SoC.
> 2) second, the pclk for uart_AO need to be fixed once G12A clock_ao driver is
> merged. In this version, it rely on bootloader to enable the pclk gate which 
> belong to AO clock domain. Please add clk_ignore_unused to bootargs.

Applied to v4.20/dt64, added Neils' Reviewed-by tag.

Kevin

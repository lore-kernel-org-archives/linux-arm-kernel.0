From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 30 Jan 2018 16:04:31 -0800
Subject: [PATCH v3 0/5] ARM64: dts: meson-axg: UART DT updates
In-Reply-To: <20180111023401.125658-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Thu, 11 Jan 2018 10:33:56 +0800")
References: <20180111023401.125658-1-yixun.lan@amlogic.com>
Message-ID: <7hr2q6c2r4.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> HI Kevin
>  These are the UART DT updates for the Meson-AXG platform.
>
>  The patch 1 is a general fix.
> Other patches are about adding clock & pinctrl info, then using them.
> Last patch enable UART_A which connect to a BT module on the S400 board.

Applied to v4.16/dt64,

Thanks,

Kevin

From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Aug 2013 14:24:58 +0800
Subject: [PATCH v3 0/3] serial: mxs-auart: add RTS/CTS check for DMA
 support
In-Reply-To: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
References: <1375538956-15862-1-git-send-email-shijie8@gmail.com>
Message-ID: <20130805062456.GG24629@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 03, 2013 at 10:09:13AM -0400, Huang Shijie wrote:
> Huang Shijie (3):
>   serial: mxs: enable the DMA only when the RTS/CTS is valid
>   serial: mxs: remove the MXS_AUART_DMA_CONFIG
>   ARM: dts: imx28-evk: add the RTS/CTS property for auart0

For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

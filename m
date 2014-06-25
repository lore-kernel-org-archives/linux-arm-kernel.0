From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Jun 2014 08:27:57 +0200
Subject: [PATCH 1/2] ARM: i.MX27: Introduce DT include for clock provider
In-Reply-To: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
References: <1403426090-29806-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140625062757.GI15686@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 22, 2014 at 12:34:49PM +0400, Alexander Shiyan wrote:
> Use clock defines in order to make devicetrees more human readable.
> Additional changes included in this patch (imx27.dtsi):
> - Fix IPG clock for UART6.
> - Use EMI_AHB_GATE clock for WEIM.
> - Added GPIO_IPG_GATE clock for GPIO nodes. Currently this clock is
>   not used by the driver, but it can be added in the future.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Looks good to me. Both:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

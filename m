From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Mar 2015 21:02:20 +0100
Subject: [PATCH v2] ARM: dts: imx25-pinfunc: Add several pinfunctions
In-Reply-To: <1427206342-10672-1-git-send-email-mpa@pengutronix.de>
References: <1427206342-10672-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20150324200220.GW5664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Markus,

On Tue, Mar 24, 2015 at 03:12:22PM +0100, Markus Pargmann wrote:
> +/* The imx25 RM appendix describes this mux as CAN1 which is wrong */
> +#define MX25_PAD_FEC_RDATA1__CAN2_TX		0x1e0 0x3d8 0x000 0x14 0x000
What about

	/*
	 * According to the i.MX25 Reference manual (IMX25RM, Rev. 2,
	 * 01/2011) this is CAN1_TX but that's wrong.
	 */

? It doesn't fit in a single line, but it's still reconstructable in
case Freescale publishes a Rev 3 which is wrong in a different way :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 1 Feb 2018 08:57:20 +0100
Subject: [PATCH v3 2/2] ARM: dts: imx25-pinfunc: Always set SION for
 eSDHC CMD
In-Reply-To: <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
References: <20180131213544.4508-1-benoit.thebaudeau.dev@gmail.com>
 <20180131213544.4508-2-benoit.thebaudeau.dev@gmail.com>
Message-ID: <20180201075720.3fj7ozvclpp6yovz@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 10:35:44PM +0100, Beno?t Th?baudeau wrote:
> The eSDHC does not work properly if the SION bit is not set for the
> bidirectional CMD signal, whatever the eSDHC instance and the selected
> pad. Therefore, setting SION is mandatory for all eSDHC CMD ports. Do
> this for MX25_PAD_*__ESDHCn_CMD in imx25-pinfunc.h in order to enforce
> this behavior for all boards.
> 
> This had already been done for eSDHC1, but not for eSDHC2. Also, define
> MX25_PAD_FEC_MDC__ESDHC2_CMD so that all the possible cases are covered
> from now on.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau.dev@gmail.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

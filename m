From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 14 Jan 2011 08:50:24 +0100
Subject: [PATCH 1/2] arm: mx50_rdp: add fec support
In-Reply-To: <1294988137-24654-1-git-send-email-richard.zhao@freescale.com>
References: <1294988137-24654-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110114075024.GB24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Fri, Jan 14, 2011 at 02:55:36PM +0800, Richard Zhao wrote:
> +static const struct fec_platform_data fec_data = {
This can be __initconst.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

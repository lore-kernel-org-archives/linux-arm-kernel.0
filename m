From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 24 Mar 2015 08:21:34 +0100
Subject: [PATCH] ARM: cygnus: fix const declaration bcm_cygnus_dt_compat
In-Reply-To: <1426981535-1800-1-git-send-email-stefan@agner.ch>
References: <1426981535-1800-1-git-send-email-stefan@agner.ch>
Message-ID: <20150324072134.GO5664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stefan,

On Sun, Mar 22, 2015 at 12:45:35AM +0100, Stefan Agner wrote:
> The const declaration for char* is actually duplicated, however
> the array of strings is currently not constant. However, typically
> the dt_compat array is declared as const char *const. Follow
> that convention and also add the __initconst macro for constant
> initialization data.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

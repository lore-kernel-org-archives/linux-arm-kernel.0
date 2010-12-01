From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Dec 2010 15:57:19 +0100
Subject: [PATCH] add clock debug information for imx51 babbage
In-Reply-To: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
References: <AANLkTi=cTYjaDh0Zd-7joLCycMcLoPW+Ekws=46QMoDc@mail.gmail.com>
Message-ID: <20101201145719.GG32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> +
> +config CLK_DEBUG
> +	bool "clock debug information export to user space"
> +	depends on PM_DEBUG && DEBUG_FS
> +	default n
You can skip that "default n" as it's the default.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

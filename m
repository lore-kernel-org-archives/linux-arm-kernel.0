From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 11 Mar 2015 08:09:49 +0100
Subject: [PATCH] clk: provide clk_is_match() dummy for non-common clk
In-Reply-To: <8682755.oK0Ae34OOP@wuerfel>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
 <1424876018-17852-2-git-send-email-shawn.guo@linaro.org>
 <20150225172757.421.43718@quantum> <8682755.oK0Ae34OOP@wuerfel>
Message-ID: <20150311070949.GH952@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, 

On Sun, Mar 08, 2015 at 10:05:29PM +0100, Arnd Bergmann wrote:
> +static inline bool clk_is_match(struct clk *p, struct clk *q)
> +{
> +	return p == q ? true : false;
OK, this is only a move, but I wonder why Russell's comment that this is
equivalent to the easier

	return p == q;

wasn't addressed?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

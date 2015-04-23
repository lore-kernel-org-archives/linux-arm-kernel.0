From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 23 Apr 2015 10:48:17 +0200
Subject: [PATCH 1/6] clk: make strings in parent name arrays const
In-Reply-To: <1429778143-2074-2-git-send-email-s.hauer@pengutronix.de>
References: <1429778143-2074-1-git-send-email-s.hauer@pengutronix.de>
 <1429778143-2074-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20150423084817.GB19431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Halli,

On Thu, Apr 23, 2015 at 10:35:38AM +0200, Sascha Hauer wrote:
> The clk functions and structs declare the parent_name arrays as
> 'const char **parent_names' which means the parent name strings
> are const, but the array itself is not. Use
> 'const char * const * parent_names' instead which also makes
> the array const. This allows us to put the parent_name arrays into
> the __initconst section.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

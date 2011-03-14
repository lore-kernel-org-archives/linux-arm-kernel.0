From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 14 Mar 2011 11:16:12 +0100
Subject: [PATCH 0/2] Common struct clk implementation, v14
In-Reply-To: <1299134429.100626.661279191478.0.gpush@pororo>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<1299134429.100626.661279191478.0.gpush@pororo>
Message-ID: <20110314101612.GD28960@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 02:40:29PM +0800, Jeremy Kerr wrote:
> Hi all,
> 
> These patches are an attempt to allow platforms to share clock code. At
> present, the definitions of 'struct clk' are local to platform code,
> which makes allocating and initialising cross-platform clock sources
> difficult, and makes it impossible to compile a single image containing
> support for two ARM platforms with different struct clks.
> 
> The three patches are for the architecture-independent kernel code,
> introducing the common clk infrastructure. The changelog for the first
> patch includes details about the new clock definitions.
> 
> Many thanks to the following for their input:
>  * Benjamin Herrenschmidt <benh@kernel.crashing.org>
>  * Ben Dooks <ben-linux@fluff.org>
>  * Baruch Siach <baruch@tkos.co.il>
>  * Russell King <linux@arm.linux.org.uk>
>  * Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>  * Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>  * Vincent Guittot <vincent.guittot@linaro.org>
>  * Sascha Hauer <s.hauer@pengutronix.de>
>  * Ryan Mallon <ryan@bluewatersys.com>
>  * Colin Cross <ccross@google.com>
>  * Jassi Brar <jassisinghbrar@gmail.com>
>  * Saravana Kannan <skannan@codeaurora.org>

Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

who is responsible to take this patch?  Russell?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

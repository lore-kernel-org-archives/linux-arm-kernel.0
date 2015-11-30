From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Nov 2015 09:15:43 +0100
Subject: [PATCH v3] clk: s3c2410: removed unneeded variable in
 s3c24xx_clkout_set_parent
In-Reply-To: <20151130075219.GA27737@jci-VirtualBox>
References: <20151130075219.GA27737@jci-VirtualBox>
Message-ID: <20151130081543.GI10431@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 07:52:22AM +0000, Mutharaju, Prasanna (P.) wrote:
> From: Prasanna Karthik <mkarthi3@visteon.com>
> 
> Remove unneeded variable used to store return value.
> ---
> v3: Modified subject and changelog comments
> ---
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>

Everything after the first triple-dash doesn't make it into the git
history, so you are expected to write the S-o-b line above the list of
things changed since a previous submission.

Other than that the patch looks fine.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

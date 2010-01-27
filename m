From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Jan 2010 11:45:37 +0100
Subject: [PATCH v3] input: MXC: add mxc-keypad driver to support the
	Keypad Port present in the mxc application processors family.
In-Reply-To: <19296.5728.557535.920849@ipc1.ka-ro>
References: <1264586106.2463.23.camel@realization>
	<19296.5728.557535.920849@ipc1.ka-ro>
Message-ID: <20100127104537.GB17421@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo Alberto,

On Wed, Jan 27, 2010 at 11:33:04AM +0100, Lothar Wa?mann wrote:
> > +	keypad->clk = clk_get(NULL, "kpp");
> >
> clk_get(&pdev->dev, "kpp");
Maybe even

	clk_get(&pdev->dev, NULL);

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |

From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 9 Sep 2011 10:26:33 +0200
Subject: [PATCH v3 4/4] ARM: i.MX5/mm: consolidate TZIC map code
In-Reply-To: <1315452447-20205-5-git-send-email-jason.hui@linaro.org>
References: <1315452447-20205-1-git-send-email-jason.hui@linaro.org>
	<1315452447-20205-5-git-send-email-jason.hui@linaro.org>
Message-ID: <20110909082633.GM28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 11:27:27AM +0800, Jason Liu wrote:
> We can use static mapping for TZIC to get rid of the
> duplicated code for ioremap and the error handling of
> ioremap, which will made code more clean and consistent
> 
> This patch also removes TZIC mapping for i.mx51 TO1 since
> there is no support for TO1 now since the following commit:
> 9ab4650f718a0e1cb8792bab4ef97efca4ac75c2
Something like

	9ab4650 (ARM: imx: Get the silicon version from the IIM module)

instead of the full hash without shortlog is generally preferred here. I
usually use

	git one 9ab4650f718a0e1cb8792bab4ef97efca4ac75c2

to get this (after doing

	git config --global alias.one "show -s --pretty='format:%h (%s)'"

once).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

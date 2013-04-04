From: cjb@laptop.org (Chris Ball)
Date: Thu, 04 Apr 2013 10:07:16 -0400
Subject: [PATCH 2/2] mmc: mxs-mmc: add non-removeable property
In-Reply-To: <1364223751-28253-3-git-send-email-mkl@pengutronix.de> (Marc
 Kleine-Budde's message of "Mon, 25 Mar 2013 16:02:31 +0100")
References: <1364223751-28253-1-git-send-email-mkl@pengutronix.de>
 <1364223751-28253-3-git-send-email-mkl@pengutronix.de>
Message-ID: <87r4iqpey3.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 25 2013, Marc Kleine-Budde wrote:
> +	host->non_removeable = of_property_read_bool(np, "non-removable");
> +	if (host->non_removeable)
> +		mmc->caps |= MMC_CAP_NONREMOVABLE;

The correct spelling is "non_removable", as used in the DT property.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

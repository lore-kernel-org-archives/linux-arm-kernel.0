From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 4 Sep 2013 17:36:24 +0300
Subject: [PATCH 2/5] Staging/iio/adc/touchscreen/MXS: separate i.MX28
 specific register bits
In-Reply-To: <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-3-git-send-email-jbe@pengutronix.de>
Message-ID: <20130904143624.GI6329@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 03:01:43PM +0200, Juergen Beisert wrote:
> +#define	LRADC_CTRL0_MX28_PLATE_MASK \
> +		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> +		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> +		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW

Put parenthesis are this macro.

regards,
dan carpenter

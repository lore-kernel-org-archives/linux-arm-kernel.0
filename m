From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Jul 2010 15:18:29 +0100
Subject: [PATCH v2 2/2] ux500: add ab8500-regulators machine specific data
In-Reply-To: <1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
References: <1279030173-3086-1-git-send-email-sundar.iyer@stericsson.com>
	<1279030173-3086-2-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <20100713141828.GB24260@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 07:39:33PM +0530, Sundar Iyer wrote:

> +static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
> +	{ .supply = "vaux1", },
> +};

It is extremely disappointing to see you reposting this without engaging
with my previous review at all.

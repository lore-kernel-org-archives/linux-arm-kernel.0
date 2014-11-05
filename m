From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 05 Nov 2014 04:24:03 +0100
Subject: [PATCH 5/7] pinctrl: Add driver for Zynq
In-Reply-To: <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <54599853.9050706@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> +	PINCTRL_PIN(54, "EMIO_SD0_WP"),
> +	PINCTRL_PIN(55, "EMIO_SD0_CD"),
> +	PINCTRL_PIN(56, "EMIO_SD1_WP"),
> +	PINCTRL_PIN(57, "EMIO_SD0_CD"),

Should this be "EMIO_SD1_CD"?

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg

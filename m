From: gardner.ben@gmail.com (Ben Gardner)
Date: Wed, 9 Sep 2009 18:28:42 -0500
Subject: [PATCH 3/4] i2c/chips: Remove deprecated pca9539-driver
In-Reply-To: <1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<1252531371-14866-4-git-send-email-w.sang@pengutronix.de>
Message-ID: <808c8e9d0909091628v3681c0cch50759d24393e570a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 9, 2009 at 4:22 PM, Wolfram Sang<w.sang@pengutronix.de> wrote:
> The pca9539-driver in drivers/i2c/chips which just exports its registers to
> sysfs is superseeded by drivers/gpio/pca953x.c which properly uses the gpiolib.
> As this driver has been deprecated for more than a year, finally remove it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Ben Gardner <gardner.ben@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>

Acked-by: Ben Gardner <gardner.ben@gmail.com>

Thanks for taking care of this.
Ben

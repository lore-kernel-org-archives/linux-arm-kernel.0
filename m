From: broonie@kernel.org (Mark Brown)
Date: Sat, 13 Sep 2014 09:28:58 -0700
Subject: [PATCH] spi: davinci: request cs_gpio's from probe
In-Reply-To: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
References: <1410533640-21469-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20140913162858.GG7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 05:54:00PM +0300, Grygorii Strashko wrote:

>  static void davinci_spi_cleanup(struct spi_device *spi)
>  {
> -	if (spi->cs_gpio >= 0)
> -		gpio_free(spi->cs_gpio);
>  }

This function is now empty so should be removed.  I've applied for now
but please send a followup fixing this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/07d71215/attachment.sig>

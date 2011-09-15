From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Sep 2011 18:24:46 -0300
Subject: [PATCH v2] spi/imx: Fix spi-imx when the hardware SPI chipselects
	are used
In-Reply-To: <20110915210108.GG3523@ponder.secretlab.ca>
References: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
	<20110915210108.GG3523@ponder.secretlab.ca>
Message-ID: <CAOMZO5DWaP0r=fRvR-VpaRWF1hLm4Cg8FF+etMpGniT8tb5O8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant,

On Thu, Sep 15, 2011 at 6:01 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
...
> It looks like the removal of this line will break DT users. ?Perhaps
> the spi_imx->chipselect[i] line should just be moved before the
> 'if (cp_gpio < 0)' line.

Yes, this is addressed in v3 now.

Thanks,

Fabio Estevam

From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 9 Jan 2018 15:41:35 +0200
Subject: [PATCH 3/4] bcm2835-gpio-exp: Driver for GPIO expander via
 mailbox service
In-Reply-To: <2013811470.181895.1514918984637@email.1und1.de>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
 <2013811470.181895.1514918984637@email.1und1.de>
Message-ID: <20180109134135.32i6slkhmqsjnmne@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Jan 02, 2018 at 07:49:44PM +0100, Stefan Wahren wrote:

[...]

> > +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_CONFIG,
> > +				    &get, sizeof(get));
> > +	if (ret) {
> > +		dev_err(gpio->dev,
> > +			"Failed to get GPIO %u config (%d)\n", off, ret);
> > +		return ret;
> > +	}
> 
> Shouldn't we also check the in-bound status at get.gpio?

What is the in-bound status value? May you refer me to the documentation?

> And in all the other gpio ops?

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -

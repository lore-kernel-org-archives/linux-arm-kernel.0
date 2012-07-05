From: marex@denx.de (Marek Vasut)
Date: Thu, 5 Jul 2012 07:46:30 +0200
Subject: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
In-Reply-To: <CAAQ0ZWQEoOy6etXhsy3uTPmiFqtVaqMf5VXUHFrp3O6R_jQ06g@mail.gmail.com>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <201207050739.49912.marex@denx.de>
 <CAAQ0ZWQEoOy6etXhsy3uTPmiFqtVaqMf5VXUHFrp3O6R_jQ06g@mail.gmail.com>
Message-ID: <201207050746.30818.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On 5 July 2012 13:39, Marek Vasut <marex@denx.de> wrote:
> >> So SPI_MXS may need to select STMP_DEVICE.
> > 
> > Ok, fixed in my tree. But, where's the meteor shower of nitpicks and such
> > stuff?
> 
> I do not take this as a nitpick at all.

No, this one is valid. I mean the remaining stuff.

> Removing those drivers
> selecting STMP_DEVICE from mxs_defconfig, your driver does not
> compile.

Correct, this I fixed in my tree and will repost the series. I also fixed the 
documentation issue. But ... what about the rest of the series, are you OK with 
it as is ?

> Regards,
> Shawn

Best regards,
Marek Vasut

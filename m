From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 5 Jul 2012 13:43:40 +0800
Subject: [PATCH 6/8] mmc: spi: Add SPI driver for mx233/mx28
In-Reply-To: <201207050739.49912.marex@denx.de>
References: <1340958180-2291-1-git-send-email-marex@denx.de>
 <1340958180-2291-6-git-send-email-marex@denx.de>
 <20120705005143.GF2595@S2101-09.ap.freescale.net>
 <201207050739.49912.marex@denx.de>
Message-ID: <CAAQ0ZWQEoOy6etXhsy3uTPmiFqtVaqMf5VXUHFrp3O6R_jQ06g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 July 2012 13:39, Marek Vasut <marex@denx.de> wrote:
>> So SPI_MXS may need to select STMP_DEVICE.
>
> Ok, fixed in my tree. But, where's the meteor shower of nitpicks and such stuff?

I do not take this as a nitpick at all.  Removing those drivers
selecting STMP_DEVICE from mxs_defconfig, your driver does not
compile.

Regards,
Shawn

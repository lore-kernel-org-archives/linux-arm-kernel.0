From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Jan 2013 15:41:49 +0100
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
In-Reply-To: <20130123125001.GG16264@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
 <20130123125001.GG16264@pengutronix.de>
Message-ID: <CACRpkdbDxY0QkKtAEgF4rn+RX_ypiknoxbnHBwn5xayooEReAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 1:50 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Wed, Jan 23, 2013 at 01:24:52PM +0100, Linus Walleij wrote:
>> On Wed, Jan 23, 2013 at 7:32 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
>>
>> > This patch adds at24c512b eeprom support.
>> > The datasheet of at24c512b can be found at:
>> > http://www.alldatasheet.com/datasheet-pdf/pdf/
>> > 256958/ATMEL/AT24C512B-TH-B.html
>> >
>> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>>
>> Arnd Bergmann is the misc maintainer, route this by him.
>
> I usually take at24 patches via my I2C tree.

Oh I didn't mean he'd merge it, I meant route it by him as
in "let him have a look at it" :-)

Yours,
Linus Walleij

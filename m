From: wangyuhang2014@gmail.com (=?GB2312?B?zfXT7rq9?=)
Date: Wed, 26 Jun 2013 18:33:17 +0800
Subject: DUAL/QUAD SPI SUPPORT
Message-ID: <CAHSAbzO2+wAmxyafDgfN-a-Q+6iWjP_Ho7-kW3g-_mC=qXp-vA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI

I met some troubles in development and I really hope that you can give
me a hand, Thanks a lot.

Question:
Now I am in developing SPI Controller Driver. But our SPI Controller
supports DUAL and QUAD modes and the slave device is a flash
chip(which also support DUAL and QUAD). Linux kernel version I am
working with is 3.0.39 and I also have checked the latest version 3.9.4,
but there is no members in the SPI related struction to support DUAL and
QUAD. In that situation I have to add members in "struct spi_transfer"
which provide the flash transfer mode(DUAL/QUAD) to spi driver.
1:So I want to know the reason that why linux SPI do not support DUAL
and QUAD modes.
2:What I expect is to add members in "struct spi_transfer" so that
slave can provide the information. Is that any problems exist?
If you think that is possible, I can provide the patch and some details


  Thank you

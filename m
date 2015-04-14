From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 14 Apr 2015 14:57:40 -0300
Subject: [PATCH] ARM: dts: imx23-olinuxino: Fix polarity of LED GPIO
In-Reply-To: <2047797975.287859.1429033877762.JavaMail.open-xchange@oxbaltgw08.schlund.de>
References: <1429020304-31045-1-git-send-email-fabio.estevam@freescale.com>
 <2047797975.287859.1429033877762.JavaMail.open-xchange@oxbaltgw08.schlund.de>
Message-ID: <CAOMZO5AF0ntbAMVF=m4e21b7AFse32Okit0HvSRRYrTYVA1vLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Tue, Apr 14, 2015 at 2:51 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
>
> I did my tests only with iMX233-Olinuxino Maxi. How about your test equipment?

Thanks for testing.

Unfortunately, I don't have access to my mx23 olinuxino board and
could not test it.

I have looked in all schematics (maxi, micro, mini and nano) and all
of them require logic level high to turn on the LED.

Regards,

Fabio Estevam

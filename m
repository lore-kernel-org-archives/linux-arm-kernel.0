From: anarsoul@gmail.com (Vasily)
Date: Thu, 29 Dec 2011 12:06:00 +0300
Subject: [PATCH v4] s3c/s3c24xx: arm: leds: Make s3c24xx LEDS driver use
 gpiolib. Fix error disabling pull during probe.
In-Reply-To: <4EE7E0E7.1020802@solonet.org.ua>
References: <4EE7E0E7.1020802@solonet.org.ua>
Message-ID: <CA+E=qVdfwXMdcN6ENeermvdoq42W3=-WvLGqRSBSxRCt=zafwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/12/14 Denis Kuzmenko <linux@solonet.org.ua>:
> Make s3c24xx LEDS driver use gpiolib. Fix error disabling pull during probe.

So, what's the difference between s3c24xx_led and leds-gpio drivers now?
Maybe it worth to convert s3c24xx_led users to leds-gpio and drop
s3c24xx-led completely?
I see no reason to keep two almost identical drivers in tree.

Regards,
Vasily

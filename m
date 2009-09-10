From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 10 Sep 2009 03:55:36 -0400
Subject: [Uclinux-dist-devel] Removing deprecated drivers from
	drivers/i2c/chips
In-Reply-To: <20090910062609.GA26454@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	<8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
	<20090910062609.GA26454@pengutronix.de>
Message-ID: <8bd0f97a0909100055n3192deeka93dc853f0139bfc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2009 at 02:26, Wolfram Sang wrote:
>> the Blackfin defconfigs refer to an input driver for the PCF8574, not
>> the I2C client driver
>
> Yup, I am aware of that. With the exception of:
>
> blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=m

thanks for double checking.  i'm not sure this board even has this
device.  i'll review the hardware.
-mike

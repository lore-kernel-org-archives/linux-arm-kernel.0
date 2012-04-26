From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Apr 2012 08:41:27 -0300
Subject: possible MXS-i2c bug
In-Reply-To: <201204261326.29388.marex@denx.de>
References: <201204261326.29388.marex@denx.de>
Message-ID: <CAOMZO5BQbyKXYEzpRrjLoyXMY9ykbJ05rtnN2aFAf=+WjQ+K0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 8:26 AM, Marek Vasut <marex@denx.de> wrote:
> Hi,
>
> I recently tried mxs-i2c (on 3.4-rc4) with at24 eeprom, didn't work as expected.
>
> Apparently, there might be some timing issue, when I put printk() into the at24
> driver eeprom write function, it "fixed" itself. Though, replacing the i2c
> driver with i2c gpio also fixed the issue, so I suspect the i2c driver has some
> flaw in it.

Does Wolfram's patch help?
http://www.spinics.net/lists/linux-i2c/msg08002.html

I don't have a I2C eeprom soldered on my mx28evk to test it.

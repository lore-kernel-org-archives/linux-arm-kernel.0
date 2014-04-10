From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 10 Apr 2014 12:49:18 -0300
Subject: Wrong SPI NOR model detected by mx6sl
Message-ID: <CAOMZO5DR00ea=zfr+eM0uh2L5a6QB93g8X48JNkXZZc4UavdZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On the imx6sl-evk there is a m25p32 spi nor flash, but in the kernel
probe we get:

m25p80 spi0.0: found mr25h256, expected m25p32
m25p80 spi0.0: mr25h256 (32 Kbytes)

On the mx6qsabresd there is also a m25p32, which is correctly detected:
m25p80 spi0.0: m25p32 (4096 Kbytes)

Any ideas as to why mx6sl detects the wrong spi nor model?

Regards,

Fabio Estevam

From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 24 Dec 2015 23:04:25 +0000
Subject: Running arm:versatile_defconfig with qemu in linux-next
In-Reply-To: <567C4CC6.40104@roeck-us.net>
References: <567B76E0.6050106@roeck-us.net> <201512241058.30249.arnd@arndb.de>
 <567C4CC6.40104@roeck-us.net>
Message-ID: <CAFEAcA86RztHcmFmCr=NQH71AdBkC7B247C7uDX3nToa_Mq7Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 December 2015 at 19:51, Guenter Roeck <private@roeck-us.net> wrote:
> I can not get the available dtb files for realview (arm-realview-pb1176.dtb
> and arm-realview-pb11mp.dtb) to work with anything I tried.

This is because QEMU does not model either of these two boards.

thanks
-- PMM

From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Mar 2014 14:59:47 +0100
Subject: [PATCH 3/3] spi: psdev: add passive serial driver
In-Reply-To: <20140314102223.GR366@sirena.org.uk>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
 <20140312163427.GV28112@sirena.org.uk>
 <20140314101907.GF4234@pengutronix.de>
 <20140314102223.GR366@sirena.org.uk>
Message-ID: <CACRpkdZoO_hXw-p5ZHeUzMHULq_DEJNzpim0mcO5DBOgP=d60A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 11:22 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Mar 14, 2014 at 11:19:07AM +0100, Michael Grzeschik wrote:
>
>> It is actually not more than that. I took the spidev character device
>> driver as reference implementation. Any Idea where to put this driver
>> instead.
>
> Like I say somewhere where it sits with other FPGA programming stuff (if
> that's what it does) would be my first thought.

I'd suggest you try to use drivers/firmware.

That subsystem is a bit x86-centrix at the moment but looking at the
stuff that is in there (like supporting BIOS updates through sysfs and
other low-level firmware communication) this stuff is close enough.

Yours,
Linus Walleij

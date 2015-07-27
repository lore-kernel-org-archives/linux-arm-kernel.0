From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 27 Jul 2015 08:10:22 +0200
Subject: [PATCH 1/5] pwm: add the Berlin pwm controller driver
In-Reply-To: <CAAEAJfA9ZH7xcKLY-qVvEbOeozxg_Vb9MjgoMBk3ceZCr00ciw@mail.gmail.com>
References: <1437860378-9556-1-git-send-email-antoine.tenart@free-electrons.com>
 <1437860378-9556-2-git-send-email-antoine.tenart@free-electrons.com>
 <CAAEAJfA9ZH7xcKLY-qVvEbOeozxg_Vb9MjgoMBk3ceZCr00ciw@mail.gmail.com>
Message-ID: <20150727061022.GN8283@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 26, 2015 at 07:56:55PM -0300, Ezequiel Garcia wrote:
> El jul. 25, 2015 6:40 PM, "Antoine Tenart" <antoine.tenart@free-electrons.com>
> escribi?:
> > +
> > +static const struct of_device_id berlin_pwm_match[] = {
> > +? ? ? ?{ .compatible = "marvell,berlin-pwm" },
> 
> Don't we need a sentinel here?

Oops. I'll fix that.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

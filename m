From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 13:12:24 +0000
Subject: [GIT PULL] [v3.3] fixes for arch-pxa in arm
In-Reply-To: <CAF+7xWnXe24ZmtrC756+kXY32KdyrrfecO2vZF7ZY4y5+XpbOw@mail.gmail.com>
References: <CAN1soZwcL-ELxwW5MB7zNQOrr0YPpo6pXp40D7uEaKH6Li0haw@mail.gmail.com>
 <201202211727.19754.arnd@arndb.de>
 <CAF+7xWnXe24ZmtrC756+kXY32KdyrrfecO2vZF7ZY4y5+XpbOw@mail.gmail.com>
Message-ID: <201202221312.24424.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 February 2012, Axel Lin wrote:
> 2012/2/22 Arnd Bergmann <arnd@arndb.de>:
> > How urgent is "pxa/hx4700: add platform device and I2C info
> > for AK4641 codec" amongst these? If not so urgent, I would prefer
> > putting this one on next/fixes-non-critical or even next/board
> > for 3.4 while applying the reset on the fixes branch for 3.3.
> 
> This patch is required since commit c26f64
> "ASoC: add iPAQ hx4700 machine driver.
> The audio on hx4700 does not work without this patch.
> 
> Actually, I think this patch should have CC stable tag for 3.0+.
> 
> I was expet to see this patch in 3.2 since I sent the patch.
> I really hope it can be upstream in 3.3 now.

Hi Axel,

I still wouldn't consider the patch a bug fix, but it's clear that
this is needed and we should have merged it much earlier.

I've merged the entire series into the fixes branch now, but in the
future I want to see patches like this separate from bug fixes
and only in the merge window.

	Arnd

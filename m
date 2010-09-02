From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Sep 2010 14:08:32 +0200
Subject: defconfig reduction script
In-Reply-To: <AANLkTink4vGs+FOk0Q-1iY2YbipJBhs_0417MCFtwu3g@mail.gmail.com>
References: <AANLkTink4vGs+FOk0Q-1iY2YbipJBhs_0417MCFtwu3g@mail.gmail.com>
Message-ID: <20100902120832.GH14214@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Thu, Sep 02, 2010 at 01:41:21PM +0200, Linus Walleij wrote:
> Uwe, do you have a copy of your defconfig reduction script at hand?
No, that's obsolete.  Just do

	make savedefconfig; mv defconfig arch/arm/configs/lala_defconfig

> I need to update some defconfigs, so I though I'd do it the normal
> way with menuconfig, then reduce it with your script and compare
> the end result with the version in configs/ (should work?)
Yes, that's the idea.
 
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 17:50:48 +0200
Subject: [PATCH v3 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <20120912085423.21af58d5@skate>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120911164409.4c030bd8@skate> <504FB869.60201@wwwdotorg.org>
 <20120912085423.21af58d5@skate>
Message-ID: <CACRpkdYVMTbfA++eqRrq6JM0phjN-X-f3N==oXbyVxCyYUVOOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 8:54 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This data structure really reflects what the datasheet says. Typically,
> for SoCs where each pin is independently muxable (AT91, i.MX23/28,
> Marvell, and probably many more), the datasheet has a big array, with
> one line per pin, and then several columns which tell for a given pin,
> what is "function 0", "function 1", "function 2", "function 3", etc.

This is a valid reason to keep it as is in my book.
Readability along with a datasheet is important, most important
is that it has a good structure for those maintaining the driver.

Is this datasheet available so I can get the picture?

Yours,
Linus Walleij

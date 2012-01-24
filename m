From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Jan 2012 00:13:06 +0100
Subject: [PATCH 3/4] ARM: tegra: Switch to new pinctrl driver
In-Reply-To: <CAOesGMjuewhO2H+QFQtAX+xFb5hyNn8Q65Cuup4vaXWAFvX87w@mail.gmail.com>
References: <1327083746-31430-1-git-send-email-swarren@nvidia.com>
 <1327083746-31430-3-git-send-email-swarren@nvidia.com>
 <CACRpkdZ_hBviswq7pXoLozC8gjzvowCBrj9yjw1xJT79b5rtwQ@mail.gmail.com>
 <CAOesGMjuewhO2H+QFQtAX+xFb5hyNn8Q65Cuup4vaXWAFvX87w@mail.gmail.com>
Message-ID: <CACRpkdayNsOFkOwLZNO_pJnNmM=NmSZhkJtAwkHxQvHovdF0uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 11:44 PM, Olof Johansson <olof@lixom.net> wrote:

> Yup, I've just been waiting on things to settle,
> bindings/implementation wise. Will look at it over the next day or two
> and get back.

The only bindings you need to look into for this patch set should be
for the driver itself, the other muxmap bindings discussion I would
*very* much like to keep orthogonal to the review of this driver.

I'm pretty scared of how device tree bindings seem to suck in
every discussion like a black hole and then explode in a myriad
fragmented discussions like a supernova :-P

Yours,
Linus Walleij

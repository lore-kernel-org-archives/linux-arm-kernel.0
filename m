From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 14:02:21 +0200
Subject: [PATCH 23/34] pinctrl: mvebu: armada-xp: rename spi to spi0
In-Reply-To: <20150609165300.GA16778@lunn.ch>
References: <1433868446-11028-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1433868446-11028-24-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150609165300.GA16778@lunn.ch>
Message-ID: <CACRpkdbXTi01MjGni_sD-_weqXepN6-eRho_VdBtzoc0Ctrnng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 9, 2015 at 6:53 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> Should this patch also contain a change to armada-xp.dtsi:

I prefer to not carry dt patches in the pinctrl tree.

That part of the kernel should one day go into a separate
git so it is OK to patch it separately through ARM SoC.

Yours,
Linus Walleij

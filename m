From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:11:02 +0200
Subject: [PATCH 2/6] pinctrl: sunxi: Move the pins definitions to a
 separate header
In-Reply-To: <20130617084106.GE16699@lukather>
References: <1370795767-9769-1-git-send-email-maxime.ripard@free-electrons.com>
 <1370795767-9769-3-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdajdrcLy6u2cKkrpYnh0Hqx8Hjx+zJ_tfpYCfJFqWCrZA@mail.gmail.com>
 <20130617084106.GE16699@lukather>
Message-ID: <CACRpkda-_6G8Uq2VEX965KeGorFSZVRD++Y2+yvp66T9pQOmEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:41 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Yes, As far as I can see, we should have a pretty complete support for
> the GPIO/muxing/IRQ on the "old" allwinner SoCs (sun4i and sun5i) now.

Lucky you! My Android tablet is an Ainol Hero 2 using Actions
Semiconductor ATM7029. They don't even publish their kernel
sources nor datasheet so no chance of supporting that thing.

Yours,
Linus Walleij

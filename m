From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 23:13:55 +0100
Subject: [PATCH 6/7] tty: of_serial: Add pinctrl support
In-Reply-To: <1358544639-14761-7-git-send-email-maxime.ripard@free-electrons.com>
References: <1358544639-14761-1-git-send-email-maxime.ripard@free-electrons.com>
 <1358544639-14761-7-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdYNOTcTVNMqD-q8sJ50nuwoXZLUJZpMXWa=mrZGnGY9+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 10:30 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> Use pinctrl to configure the SoCs pins directly from the driver.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

You can poke Greg about this which is fun because it does become
superfluous with the patch titled
"[PATCH v4] drivers/pinctrl: grab default handles from device core"
http://marc.info/?l=linux-kernel&m=135879594515932&w=2

Which will auto-grab the default state on any device.

Greg, can I have your ACK on that device core grab patch
so you don't have to merge this patch but can point out that
it solves the boilerplate problem?

Yours,
Linus Walleij

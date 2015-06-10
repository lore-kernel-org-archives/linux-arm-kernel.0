From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 09:13:55 +0200
Subject: [PATCH v2 06/10] pinctrl: berlin: use proper compatibles
In-Reply-To: <1425654328-26298-7-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
 <1425654328-26298-7-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkda-4SahLjwe09D-Hb8p0nQFdG1Zc_xvLPwLGYQMkJQaXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 6, 2015 at 4:05 PM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:

> The Berlin pin-controller driver was sharing the chip and system
> controller nodes with the clock and the reset drivers. They all shared
> the same compatible. With the introduction of the Marvell Berlin MFD
> controller, the Berlin pin-controller driver has now its own node.
> Update its compatibles to not share anymore the ones of the chip and
> system controllers.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Antoine, how is this series going?

If I can merge some of it to pinctrl let me know.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

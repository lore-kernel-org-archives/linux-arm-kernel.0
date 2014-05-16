From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 May 2014 14:43:58 +0200
Subject: [PATCH v3 0/7] ARM: berlin: add pinctrl support
In-Reply-To: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1399267649-20218-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdYJU3HN2u=eFPUyM4eMmuT1Xw19zxjpb5nj9nXnar3_-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 5, 2014 at 7:27 AM, Antoine T?nart
<antoine.tenart@free-electrons.com> wrote:

> This series adds support for the Marvell Berlin pin-controller, allowing
> to configure the pin muxing from the device tree.

OK looking good!

I've applied patches 1,2,3,4 and 6 to the pin control tree.

Please carry patches 5 and 7 in the MVEBU tree or wherever
the core SoC is stashed up. It'd not be necessary to pull in the
pin control tree I think since you're just selecting symbols and
adding device trees. (The dependencies will magically fall in
during the merge window, so this is bisectable.)

Yours,
Linus Walleij

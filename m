From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 13:40:47 +0200
Subject: [PATCH v3 2/7] pinctrl: sunxi: disable clk when failing to probe
 pin controller
In-Reply-To: <1397137966-30818-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACRpkdYQ-rTTNukXA+6vN=Qce1hxYSBc5MNM84dYweBu52jfag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:

> Disable the clk when failing to probe the pin controller device.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij

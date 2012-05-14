From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 May 2012 10:42:59 +0200
Subject: [PATCH 1/2] pinctrl: mxs: create group for pin config node
In-Reply-To: <1336922341-7089-2-git-send-email-shawn.guo@linaro.org>
References: <1336922341-7089-1-git-send-email-shawn.guo@linaro.org>
 <1336922341-7089-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdYu-n8GkQkByhKsjsA-r61E7zA+5eDgQ-cpi6L+H+LQ5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2012 at 5:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The initial mxs pinctrl support, commit 1772311 (pinctrl: add
> pinctrl-mxs support) skipped creating group from device tree pin config
> node. ?Add it to get pin config node work for client device.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, applied.
Linus Walleij

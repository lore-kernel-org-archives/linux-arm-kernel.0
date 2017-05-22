From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 10:48:53 +0200
Subject: [PATCH v2 00/10] Initial Allwinner R40 support
In-Reply-To: <20170504135006.16483-1-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
Message-ID: <CACRpkdYwsyo6YT6SinisMDxhGEox5iRHZgO7xQpv-xTMjy-FOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 3:49 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> This is the first non-RFC version of this patchset, which added basical
> support including I2C, UART and MMC to the mainline Linux.
>
> The pinctrl driver of A20 is also merged into the one of A10 before
> R40 support is added into the A10 driver.

I'd be happy to merge the pinctrl parts as soon as you fixed the
things pointed out during review. Include Rob's ACKs on the
DT binding patches please.

Yours,
Linus Walleij

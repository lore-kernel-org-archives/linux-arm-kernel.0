From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Mar 2015 17:18:05 +0100
Subject: [PATCH] pinctrl: imx: do not implicitly set pin regs to -1
In-Reply-To: <1423240256-27210-1-git-send-email-stefan@agner.ch>
References: <1423240256-27210-1-git-send-email-stefan@agner.ch>
Message-ID: <CACRpkdb1iTf4YjJ1r4Mq-jOun+J95ofRG8AkG+Oj6Of-m1=S0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 6, 2015 at 5:30 PM, Stefan Agner <stefan@agner.ch> wrote:

> Commit 3dac1918a491 ("pinctrl: imx: detect uninitialized pins") needs
> the values in struct imx_pin_reg to be -1. This has been done in a
> rather unorthodox way by setting the memory to 0xff using memset...
> Use a proper for loop to initialize the whole array with -1.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied with the ACKs.

Yours,
Linus Walleij

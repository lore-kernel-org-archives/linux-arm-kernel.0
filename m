From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 15:05:08 +0800
Subject: [PATCH 14/22] ARM: ux500: Provide regulator support for SMSC911x
 via Device Tree
In-Reply-To: <1338353260-10097-15-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-15-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaH=tL7JotMEgYq90Q8qF5onWt+ELpS0Oi8T5rWhkSSng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch adds a fixed regulator for use by the SMSC911x Ethernet
> chip driver into the db8500 Device Tree. It also references other
> regulators required by the same device.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

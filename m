From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 13:49:08 +0100
Subject: [PATCH v7 01/15] Revert "pinctrl: single: support gpio request
 and free"
In-Reply-To: <1358494279-16503-2-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdaskFSEdH1Uke3c=x9BkaE-+tLHtvYRUwL4148KOwh84A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> This reverts commit 2e8b2eab94c35d83bb7da71c63b4695f32ddca88.
>
> Conflicts:
>         drivers/pinctrl/pinctrl-single.c
>
> ERROR: "__aeabi_uldivmod" [drivers/pinctrl/pinctrl-single.ko]
> undefined!]

Applied to fixes with Tony's ACK.

I also took the liberty to add your Signed-off-by.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:44:14 +0200
Subject: [PATCH 7/9] ARM: ux500: Add a VQMMC (level-shifting) regulator DT
 node for Snowball
In-Reply-To: <1364908916-29803-7-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaVWUq5dQ7ktGAhSmKkWs7DvKrHtQng106ccD27hp_HuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Until recently platform code took care of all MMCI level-shifting by
> way of an ios_handler() call-back. Now it is the driver's responsibility
> to handle. In order to so that we need to provide the VQMMC regulator
> reference in Device Tree. This patch takes care of that.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied, thanks!

Yours,
Linus Walleij

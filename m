From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:42:41 +0200
Subject: [PATCH 6/9] ARM: ux500: Create a new of_dev_auxdata structure for
 u8540 enablement
In-Reply-To: <1364908916-29803-6-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-6-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda8Zfc_AvHkqACA7UjdSSAphbu5rUBBktN_awwiSTQAaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If we attempt to use the existing u8500 of_dev_auxdata struct to boot
> the u8540, we fail to obtain a console, due to a lack of DMA support
> on the platform.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Thanks,
Linus Walleij

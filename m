From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:16:16 +0200
Subject: [PATCH 15/22] ARM: ux500: Stop registering the MOP500 Audio
 driver from platform code
In-Reply-To: <1344527268-5964-16-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdabmQaQeSuwoBY7DxvSOyPDRWvSBDm+Yn-fJP5eWybuMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> In this patch we prevent MOP500 driver registration from platform
> code and rely solely on Device Tree to do the probing for us.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

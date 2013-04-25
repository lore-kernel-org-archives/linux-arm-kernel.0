From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 15:15:19 +0200
Subject: [PATCH 09/10] ARM: ux500: Remove ux500-musb platform registation
 when booting with DT
In-Reply-To: <1366729394-11406-10-git-send-email-lee.jones@linaro.org>
References: <1366729394-11406-1-git-send-email-lee.jones@linaro.org>
 <1366729394-11406-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbKDoTscjxhHw7hTG2xZn_AJa23o19dQcLB7vAdZ156WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 5:03 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now the ux500-musb driver has been enabled for Device Tree, there is no
> requirement to register it from platform code.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

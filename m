From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 30 May 2012 14:48:08 +0800
Subject: [PATCH 04/22] ARM: ux500: Remove DB8500 PRCMU platform
 registration when DT is enabled
In-Reply-To: <1338353260-10097-5-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
 <1338353260-10097-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYUv4FoMjUstp86gXLUvhiE5LjdSyTUZW3479gfswCeLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 12:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now the DB8500 has Device Tree support it will be probed when the DT
> is parsed, rendering the requirement for platform registration void.
> This patch removes DB8500 PRCMU platform registration.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

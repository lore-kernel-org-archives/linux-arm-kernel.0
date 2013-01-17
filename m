From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 11:57:41 +0100
Subject: [PATCH] ARM: ux500: Include the PRCMU's Secure Registers in
 DB8500's DT
In-Reply-To: <1357901029-9073-1-git-send-email-lee.jones@linaro.org>
References: <1357901029-9073-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZhRESXHNVFPzUx7H0ppZ+KSfPOJ2bPS+-CQyv6+8=oZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 11:43 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Currently we only include the PRCMU's primary registers when
> referencing the register count in the 'reg' property. This patch
> expands that count to include the secure registers also.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will you push this to ARM SoC or shall I queue it?

Yours,
Linus Walleij

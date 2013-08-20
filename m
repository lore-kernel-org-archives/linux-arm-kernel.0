From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Aug 2013 11:13:43 +0200
Subject: [PATCH 3/16] arch/arm/mach-ux500/cpu-db8500.c: Avoid using
 ARRAY_AND_SIZE(e) as a function argument
In-Reply-To: <1376239917-15594-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1376239917-15594-1-git-send-email-Julia.Lawall@lip6.fr>
 <1376239917-15594-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdbwpjE38=-+JmWAAyqqT4mnp-y6_=fkT1BmmKDXCiXb6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 6:51 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Replace ARRAY_AND_SIZE(e) in function argument position to avoid hiding the
> arity of the called function.

Patch applied.

Yours,
Linus Walleij

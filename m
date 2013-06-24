From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:09:14 +0200
Subject: [RFC PATCH v2 01/12] dmaengine: PL08x: Refactor
 pl08x_getbytes_chan() to lower indentation
In-Reply-To: <1371933764-24875-2-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdYuF7Scg4n4a_EL2WW3qyFV5f5Vr-6RPohE-4O0wd=QpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Further patch will introduce support for PL080S, which requires some
> things to be done conditionally, thus increasing indentation level of
> some functions even more.
>
> This patch reduces indentation level of pl08x_getbytes_chan() function
> by inverting several conditions and returning from function wherever
> possible.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

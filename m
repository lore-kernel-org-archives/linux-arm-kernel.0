From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:25:44 +0200
Subject: [RFC PATCH 01/11] dma: amba-pl08x: Use bitmap to pass variant
 specific quirks
In-Reply-To: <1371416058-22047-2-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdYAm9BRVjFLwScnwK7SCm8z=4=_DUBhYPna=ywzzpJSMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Instead of defining new bool field in vendor_data struct for each quirk,
> it is more reasonable to use a single flags field and make each quirk
> use single bits.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Not that I see the point, but I have no strong preference so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

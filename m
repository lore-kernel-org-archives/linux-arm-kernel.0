From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 21:15:15 +0100
Subject: [PATCH] gpio: Remove duplicate include of errno.h
In-Reply-To: <1384864362-21018-1-git-send-email-manishv.b@ti.com>
References: <1384864362-21018-1-git-send-email-manishv.b@ti.com>
Message-ID: <CACRpkdb=NDnYDJe8y1CrkRsVpZCUiMQkf+u58MSp20uzjOa=BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 1:32 PM, Vishwanathrao Badarkhe, Manish
<manishv.b@ti.com> wrote:

> From: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>
>
> Currently, code include errno.h twice. Remove one inclusion
> of errno.h
>
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>

Patch applied, thanks!

Yours,
Linus Walleij

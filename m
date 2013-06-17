From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:53:14 +0200
Subject: [RFC PATCH 07/11] dmaengine: PL08x: Fix reading the byte count in
 cctl
In-Reply-To: <1371416058-22047-8-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-8-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZW0+wcVGrj1fD-1-UigjVQA7Wad7wEQ2CxFoyod2-YpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> From: Alban Bedel <alban.bedel@avionic-design.de>
>
> There are more fields than just SWIDTH in CH_CONTROL register, so read
> register value must be masked in addition to shifting.
>
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Are we just lucky on current variants such that all unmasked bits
happen to be zero on them?

Yours,
Linus Walleij

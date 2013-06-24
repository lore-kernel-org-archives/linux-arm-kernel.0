From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:11:15 +0200
Subject: [RFC PATCH v2 02/12] dmaengine: PL08x: Add support for different
 offset of CONFIG register
In-Reply-To: <1371933764-24875-3-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-3-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdatCWT0zd4VW3oiSUpg8Zz+xOEB+PUjFym1Q5RHQix3Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> Some variants of PL08x (namely PL080S, found in Samsung S3C64xx SoCs)
> have CONFIG register at different offset. This patch makes the driver
> use offset from vendor data struct.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

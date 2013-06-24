From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:28:48 +0200
Subject: [RFC PATCH v2 06/12] dmaengine: PL08x: Fix reading the byte count
 in cctl
In-Reply-To: <1371933764-24875-7-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-7-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdbq6PoMbKGeVWdj=j9=O67cXu-Y0wRJ3SKjn8K339qf=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> From: Alban Bedel <alban.bedel@avionic-design.de>
>
> There are more fields than just SWIDTH in CH_CONTROL register, so read
> register value must be masked in addition to shifting.
>
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

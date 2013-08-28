From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 21:12:32 +0200
Subject: [PATCH 3/3] ARM: PCI: versatile: Fix SMAP register offsets
In-Reply-To: <1377190070-7305-4-git-send-email-peter.maydell@linaro.org>
References: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
 <1377190070-7305-4-git-send-email-peter.maydell@linaro.org>
Message-ID: <CACRpkdaO4RyijsiWdhm1GYVOmiGnHfjh1NSb9RFUJP5bUp=AGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 6:47 PM, Peter Maydell <peter.maydell@linaro.org> wrote:

> The SMAP register offsets in the versatile PCI controller code were
> all off by four.  (This didn't have any observable bad effects
> because on this board PHYS_OFFSET is zero, and (a) writing zero to
> the flags register at offset 0x10 has no effect and (b) the reset
> value of the SMAP register is zero anyway, so failing to write SMAP2
> didn't matter.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

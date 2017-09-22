From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 22 Sep 2017 13:25:52 +0200
Subject: [PATCH v2] mmc: dt-bindings: Add reg/source_cg/latch-ck for
 Mediatek MMC bindings
In-Reply-To: <1505958774-14410-1-git-send-email-chaotian.jing@mediatek.com>
References: <1505958774-14410-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CACRpkdaco5XnWK-gAdGLWFZtjqnM16iT424ist5Zmd3RyAXAEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 3:52 AM, Chaotian Jing
<chaotian.jing@mediatek.com> wrote:

> +- mediatek,latch-ck: Some projects do not support enhance_rx, need set correct latch-ck to avoid data crc
> +                    error caused by stop clock(fifo full)

I think I wrote elsewhere: replace "projects" with "systems" or "SoCs".

Yours,
Linus Walleij

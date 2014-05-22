From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 May 2014 20:52:38 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <5057707.jNCXlqf9dH@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5678119.IM3FN0FlT6@wuerfel> <20140522144503.GA27931@arm.com>
 <5057707.jNCXlqf9dH@wuerfel>
Message-ID: <CACRpkdZX=UFhMfUn68hA+s2FLGRYy_dmjRng_fHtAQEhah0oRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 5:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 22 May 2014 15:45:03 Catalin Marinas wrote:

>> Anyway, I don't think we have any streaming DMA used on these RealView
>> boards.
>
> Yes, I think that is correct. MMCI, SSP and serial could all use
> DMA but are not configured to do it.

PB1176 has no working DMA (borked DMA hardware), the PB11MPCore
actually has working DMA but only on UART TX and maybe AACI
(haven't tested) no clue about the Cortex boards PBA8 and PBX though.

Yours,
Linus Walleij

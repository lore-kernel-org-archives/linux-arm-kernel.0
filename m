From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sun, 7 May 2017 18:39:03 +0200 (CEST)
Subject: [PATCH 1/4] ata: Add DT bindings for Faraday Technology FTIDE010
In-Reply-To: <20170506121053.11554-1-linus.walleij@linaro.org>
References: <20170506121053.11554-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1705071837310.18983@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Sat, 6 May 2017, Linus Walleij wrote:

> This adds device tree bindings for the Faraday Technology
> FTIDE010 found in the Storlink/Storm/Cortina Systems Gemini SoC.
> 
> I am not 100% sure that this part if from Faraday Technology but
> a lot points in that direction:
> 
> - A later IDE interface called FTIDE020 exist and share some
>   properties.
> 
> - The SATA bridge has the same Built In Self Test (BIST) that the
>   Faraday FTSATA100 seems to have, and it has version number 0100
>   in the device ID register, so this is very likely a FTSATA100
>   bundled with the FTIDE010.
> 
> Cc: devicetree at vger.kernel.org
> Cc: John Feng-Hsin Chiang <john453@faraday-tech.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

nice work !
you can add my

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>

on the whole patch set.

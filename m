From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 22 Nov 2017 15:21:38 +0900
Subject: [PATCH] nvmem: uniphier: change access unit from 32bit to 8bit
In-Reply-To: <1511327699-26396-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1511327699-26396-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNATpQT1Sqty+N3UHdut6yca3BxpNKSOShS27Ay88YT6xVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-22 14:14 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> The efuse on UniPhier allows 8bit access according to the specification.
> Since bit offset of nvmem is limited to 0-7, it is desiable to change
> access unit of nvmem to 8bit.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>


Tested on LD4, sLD8, Pro4, PXs2, LD11, LD20, and PXs3.
All worked for me.

Tested-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks.


-- 
Best Regards
Masahiro Yamada

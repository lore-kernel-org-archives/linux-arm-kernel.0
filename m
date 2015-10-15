From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 15 Oct 2015 19:54:05 +0900
Subject: [PATCH] ARM: dts: uniphier: fix IRQ number for devices on
 PH1-LD6b ref board
In-Reply-To: <1444899496-1124-1-git-send-email-yamada.masahiro@socionext.com>
References: <1444899496-1124-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASoH3dT5NERMAJMQxCw_euugqMaoYa5Yk92C6Ai033iBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-15 17:58 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The IRQ signal from external devices on this board is connected to
> the XIRQ1 pin of the SoC.  The IRQ number should be 51, not 50.
>
> Fixes: a5e921b4771f ("ARM: dts: uniphier: add ProXstream2 and PH1-LD6b SoC/board support")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> Hi Olof and Arnd,
>
> Could you apply this simple fix for Linux 4.13, please?
> (if it is troublesome, I can wait until Linux 4.14-rc1.)
>
> Thanks
>


This patch turned out wrong.
I retract this one and will send v2 later.

Sorry.




-- 
Best Regards
Masahiro Yamada

From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 7 Mar 2016 18:30:18 +0900
Subject: [PATCH 0/2] ARM: uniphier: UniPhier updates for Linux 4.6-rc1
 (2nd round)
In-Reply-To: <1456470968-7900-1-git-send-email-yamada.masahiro@socionext.com>
References: <1456470968-7900-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARSGsyDmSYMPOMUWS+5rYPxV2v1ieWvsAsKfQN0tZnytw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,


I have two series for 4.6-rc1 that have not been applied yet.

 - ARM: uniphier: UniPhier updates for Linux 4.6-rc1 (2nd round)   (this series)
 - ARM: dts: uniphier: UniPhier DT updates for Linux 4.6-rc1 (2nd round)

I am getting uneasy because it is already -rc7.

I hope you will find some time to check them out.


2016-02-26 16:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Olof,
>
> Here is a small patch series for UniPhier SoC updates.
>
>
>
> Masahiro Yamada (2):
>   ARM: uniphier: add missing of_node_put()
>   ARM: uniphier: rework SMP code to support new System Bus binding
>
>  arch/arm/mach-uniphier/platsmp.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada

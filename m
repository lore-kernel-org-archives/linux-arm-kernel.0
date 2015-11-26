From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 26 Nov 2015 11:30:57 +0900
Subject: [PATCH 0/4] arm, arm64: uniphier: add a new driver,
 device tree updates
In-Reply-To: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
References: <1448357962-12259-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNASKQBoSHA1WRaLYjaFfv-a8s5Vhm-wbGtQbj0kDfBT5pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-24 18:39 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Arnd, Olof,
>
> Here is another series for UniPhier SoC family:
>
>  - 1/4: add a new driver.  The UniPhier System Bus is an external bus
>         where on-board devices are connected to the SoC.
>         (please check if the binding specification is OK.)
>
>  - 2/4: device tree updates to use the driver added by 1/4
>
>  - 3/4: trivial rename of device node names
>
>  - 4/4: initial commit for ARMv8 SoC/Board device trees
>
> Please apply 2/4, 3/4/, 4/4 into the same branch because 4/4 depends on 2/4 and 3/4.
> (4/4 creates symbolic links to ARM device trees.)


It looks like 1/4 will take longer, so want to postpone it for now.


I will resend 4/4 as a single patch.


-- 
Best Regards
Masahiro Yamada

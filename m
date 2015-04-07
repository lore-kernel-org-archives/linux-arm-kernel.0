From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 7 Apr 2015 10:43:19 +0200
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20150407111217.2b2cf440@canb.auug.org.au>
References: <20150407111217.2b2cf440@canb.auug.org.au>
Message-ID: <CABuKBe+iBfmxHat3Ezinpd-85CA5m1f2gYydk=uW4SwABQ-0Wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-07 3:12 GMT+02:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> In file included from arch/arm/boot/dts/mt8135.dtsi:18:0,
>                  from arch/arm/boot/dts/mt8135-evbp1.dts:16:
> arch/arm/boot/dts/mt8135-pinfunc.h:18:40: fatal error: dt-bindings/pinctrl/mt65xx.h: No such file or directory
>  #include <dt-bindings/pinctrl/mt65xx.h>
>                                         ^
>
> Caused by commit e6f219b8ec5e ("ARM: dts: mt8135: Add pinctrl/GPIO/EINT
> node for mt8135").

This will be fixed as soon as Linus pinctrl for-next branch got merged [1].

Cheers,
Matthias

[1] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=for-next&id=a6df410d420aa4ff316797d352f69e7ebae5ff98

>
> I have reverted that commit for today.
> --
> Cheers,
> Stephen Rothwell                    sfr at canb.auug.org.au



-- 
motzblog.wordpress.com

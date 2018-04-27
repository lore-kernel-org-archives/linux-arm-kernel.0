From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 Apr 2018 13:27:35 +0900
Subject: [PATCH] arm64: dts: uniphier: stabilize ethernet of LD20
 reference boar
In-Reply-To: <1524803118-32570-1-git-send-email-yamada.masahiro@socionext.com>
References: <1524803118-32570-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAS6gc1CwvzQTUu+eC9vPO4R1tKtoEzOT-1anHAPEt=cmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-27 13:25 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Currently, the ethernet RGMII mode on the LD20 reference board is
> unstable.
>
> The default drive-strength of ethernet TX pins is too strong because
> there is no dumping resistor on the TX lines on the board.
>
> Weaken the drive-strength to make the ethernet more stable.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


To myself:

Fix the typo in the subject

  boar  ->  board




-- 
Best Regards
Masahiro Yamada

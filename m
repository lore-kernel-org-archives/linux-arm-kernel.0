From: b32955@freescale.com (Huang Shijie)
Date: Fri, 24 May 2013 10:41:53 +0800
Subject: [PATCH V2 4/6] ARM: dts: imx6q: add pinctrl for WEIM NOR
In-Reply-To: <1369302906.444557883@f310.mail.ru>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369301996.738631947@f310.mail.ru> <519DE6D0.2040909@freescale.com>
 <1369302906.444557883@f310.mail.ru>
Message-ID: <519ED371.4060703@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?23? 17:55, Alexander Shiyan ??:
>>> How we should define CS1 pin in your example for second device?
>> But in the imx6q{dl}-sabreauto boards, we only have the NOR connected to
>> WEIM.
>> I do not need to worry about the second device.
> OK, but you add "weim-NOR" to the arch/arm/boot/dts/imx6q.dtsi, not
> in imx6qdl-sabreauto.dtsi, so you mean that this definition is generic.
> Should it be moved to imx6qdl-sabreauto.dtsi then?
okay. I will split out the CS pad to single pinctrl.

thanks for your review.

Huang Shijie

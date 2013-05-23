From: b32955@freescale.com (Huang Shijie)
Date: Thu, 23 May 2013 17:27:37 +0800
Subject: [PATCH V2 4/6] ARM: dts: imx6q: add pinctrl for WEIM NOR
In-Reply-To: <1369300440.725629549@f101.mail.ru>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369296978-7669-5-git-send-email-b32955@freescale.com>
 <1369300440.725629549@f101.mail.ru>
Message-ID: <519DE109.1030903@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?23? 17:14, Alexander Shiyan ??:
> I suggest remove "nor" label here since it can be used for other devices later.
this pinctrl is just for NOR.

If we attach other device to WEIM, it maybe needs other PAD, such as

MX6Q_PAD_EIM_LBA__EIM_LBA_B.  We need to add another pinctrl then.



>> >  +						fsl,pins =<
>> >  +							MX6Q_PAD_EIM_CS0__EIM_CS0_B   0xb0b1
> Since driver can support multiple chipselects it would be nice to
> define EIM_CSX in other place for possible using other chipselects.
>
Ditto.

thanks
Huang Shijie

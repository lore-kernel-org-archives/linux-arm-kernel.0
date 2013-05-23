From: b32955@freescale.com (Huang Shijie)
Date: Thu, 23 May 2013 17:52:16 +0800
Subject: [PATCH V2 4/6] ARM: dts: imx6q: add pinctrl for WEIM NOR
In-Reply-To: <1369301996.738631947@f310.mail.ru>
References: <1369296978-7669-1-git-send-email-b32955@freescale.com>
 <1369300440.725629549@f101.mail.ru> <519DE109.1030903@freescale.com>
 <1369301996.738631947@f310.mail.ru>
Message-ID: <519DE6D0.2040909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?23? 17:39, Alexander Shiyan ??:
> How we should define CS1 pin in your example for second device?
>

But in the imx6q{dl}-sabreauto boards, we only have the NOR connected to 
WEIM.
I do not need to worry about the second device.


If in customer's boards, they connect two devices to the weim.
they should add their own special pinctrl for the two devices, such as 
split out the CS pad.

But for the imx6q{dl}-sabreauto boards, i do not need to do so.




thanks
Huang Shijie

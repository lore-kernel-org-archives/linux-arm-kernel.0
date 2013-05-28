From: b32955@freescale.com (Huang Shijie)
Date: Tue, 28 May 2013 13:51:49 +0800
Subject: [PATCH v3 5/6] ARM: dts: imx6dl: add pinctrls for WEIM NOR
In-Reply-To: <60BA5429A0E1584BA3633194F6F993B5025754D1@NA-MBX-03.mgc.mentorg.com>
References: <1369389564-13181-1-git-send-email-b32955@freescale.com>,
 <1369389564-13181-6-git-send-email-b32955@freescale.com>
 <60BA5429A0E1584BA3633194F6F993B5025754D1@NA-MBX-03.mgc.mentorg.com>
Message-ID: <51A445F5.4050206@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?25? 01:51, Chaiken, Alison ??:
> n your patch, the address lines are set to 0xb0b1, which is correct, as hysteresis is disabled and SRE is fast for those lines.     However, for data lines, hysteresis is enabled and SRE is slow, so the 0x1b0b0 setting is more appropriate.
0xb0b1 is the legacy value from the BSP code. But i agree that 0x1b0b0 
is better.
I will use it in next version.

thanks
Huang Shijie

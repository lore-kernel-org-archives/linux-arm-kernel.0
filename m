From: b32955@freescale.com (Huang Shijie)
Date: Thu, 20 Mar 2014 18:56:16 +0800
Subject: [PATCH] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <20140320110914.731db7cf@ipc1.ka-ro>
References: <1395235406-13449-1-git-send-email-y>	<532AB1A2.9010702@freescale.com>	<20140320102153.7106f915@ipc1.ka-ro>	<532AB94D.1050406@freescale.com>
 <20140320110914.731db7cf@ipc1.ka-ro>
Message-ID: <532AC950.6070108@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?03?20? 18:09, Lothar Wa?mann ??:
> This can be disabled by parameter in the FCB (at least according to
> the i.MX6 reference Manual):
from imx28's reference manual, there is not such bit in the FCB to 
disable the
swapping. But you are disabling the swapping in the imx28's DTS file, 
isn't it?

I think it is dangerous.



> |DISBBM 172 4 If 0 ROM will swap BadBlockMarkerByte with
> |             metadata[0] after reading a page using BCH40.
> |             If the value set is 1 then ROM will not do
> |             swapping
>
>
I will consult with our ROM colleague about this DISBBM bit.

I am not sure if the ROM still do the swapping for the uboot when we set 
DISBBM bit.

thanks
Huang Shijie

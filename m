From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 4 Jul 2016 16:48:08 +0200
Subject: [PATCH] ARM: defconfig/at91: Add Bosch M_CAN driver
In-Reply-To: <577A1D8A.8080108@atmel.com>
References: <1467616514-23589-1-git-send-email-wenyou.yang@atmel.com>
 <577A1D8A.8080108@atmel.com>
Message-ID: <20160704144808.GI20045@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2016 at 10:25:46 +0200, Nicolas Ferre wrote :
> Le 04/07/2016 09:15, Wenyou Yang a ?crit :
> > Add CONFIG_CAN_M_CAN=y option to enable Bosch M_CAN device driver.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> It seems not present in multi_v7 as well: can you please add it as a module?
> 

Can you also explain why this is needed, there isn't any device tree using
it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 22 Nov 2011 13:50:36 +0000
Subject: placeholder for GPIO based PWM Haptics Driver
Message-ID: <1BAFE6F6C881BF42822005164F1491C30331AC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on a platform which has a GPIO based Haptics Module driven using PWM signals. I am developing a GPIO client driver for the same. 

The design is as below

Haptics Driver --> gets duty-cycle, period --> calculates pwm signal required --> pass pwm to gpio --> drive the Haptics motor.

Where should I place the driver under Linux source Tree?

Thanks & Regards
Gururaja

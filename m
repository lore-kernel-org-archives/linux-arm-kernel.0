From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Oct 2015 14:36:00 -0700
Subject: [PATCH] ARM: dts: Add am335x-bonegreen
In-Reply-To: <1443193831-5693-1-git-send-email-robertcnelson@gmail.com>
References: <1443193831-5693-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <20151012213559.GB23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [150925 08:14]:
> SeeedStudio BeagleBone Green (BBG) is clone of the BeagleBone Black (BBB) minus
> the HDMI port and addition of two Grove connectors (i2c2 and usart2).
> 
> This board can be identified by the 1A value after A335BNLT (BBB) in the at24 eeprom:
> 1A: [aa 55 33 ee 41 33 33 35  42 4e 4c 54 1a 00 00 00 |.U3.A335BNLT....|]
> 
> http://beagleboard.org/green
> http://www.seeedstudio.com/wiki/Beaglebone_green

Thanks applying into omap-for-v4.4/dt.

Tony

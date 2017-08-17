From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Aug 2017 09:22:34 -0700
Subject: [PATCH v2] ARM: dts: am57xx-beagle-x15: Add support for rev C
In-Reply-To: <20170816165053.19450-1-robertcnelson@gmail.com>
References: <20170816165053.19450-1-robertcnelson@gmail.com>
Message-ID: <20170817162233.GA6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [170816 09:51]:
> Latest update to the BeagleBoard-X15 platform (revision C). This board contains
> a silicon update (Rev 2.0), which includes a fix for the 2nd ethernet phy when
> running at 1000 Mbps speeds.
> 
> This board can be indentified by the [C.00] after [BBRDX15_] in the at24 eeprom:
> [BBRDX15_C.001731PX150249]
> 
> Rev C is now in full production and boards are available for end users.

Thanks applying into omap-for-v4.14/dt-v3.

Regards,

Tony

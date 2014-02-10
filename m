From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 10 Feb 2014 10:53:42 -0500
Subject: [PATCH v3 0/4] ARM: keystone: enable gpio support
In-Reply-To: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
References: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52F8F606.3020107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 February 2014 11:41 AM, Grygorii Strashko wrote:
> This series adds Keystone GPIO IP definition in DT and enable GPIO support in
> Keystone configuration file.
> 
> Also, it enables LEDs support for Keystone 2 K2H EVM as specified in board 
> schematic. For more information see:
> - http://www.advantech.com/Support/TI-EVM/EVMK2HX.aspx 
> 
> Changes in v3:
>  - rebased on top 3.14 + "[PATCH v2] arm: dts: keystone: add watchdog entry"
>    http://www.spinics.net/lists/devicetree/msg20211.html
> 
> [v1-v2] http://www.spinics.net/lists/arm-kernel/msg294655.html
> 
> Grygorii Strashko (4):
>   ARM: dts: keystone: add gpio device entry
>   ARM: dts: keystone-evm: add leds supports
>   ARM: keystone_defconfig: enable gpio support
>   ARM: keystone_defconfig: enable led support
> 
Thanks for reposting the patchset Grygorii. I will
take them for the 3.15.

Would be good to get the blessing from DT folks
on first two patches.

Regards,
Santosh

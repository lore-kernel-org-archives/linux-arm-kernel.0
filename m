From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Tue, 11 Sep 2012 06:38:59 +0000
Subject: [PATCH v2 0/2] ARM: dts: AM33xx: Correct gpio labels to match docs
In-Reply-To: <1347306312-31533-1-git-send-email-mporter@ti.com>
References: <1347306312-31533-1-git-send-email-mporter@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB06D5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 01:15:10, Porter, Matt wrote:
> Changes since v1:
> 	- Series now applies on top of Anil's AM33XX DTS series
>  
> This series applies on top of the for_3.7/dts/ branch and Anil's
> "[v7,2/3] arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone"
> patch that is part of the overall series adding led and pinctrl DTS data
> for AM33xx.
> 
> It is intended to correct the current labeling of gpios in the DTS before
> too many more drivers are submitted for AM33xx that have gpios not matching
> the docs.
> 
> Matt Porter (2):
>   ARM: dts: AM33XX: fix gpio node numbering to match hardware
>   ARM: dts: AM33XX: adjust leds to use the corrected gpio label
> 

I have tested this series on BeagleBone, also validated LED functionality.

Tested-Acked-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav

>  arch/arm/boot/dts/am335x-bone.dts |    8 ++++----
>  arch/arm/boot/dts/am33xx.dtsi     |    8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> -- 
> 1.7.9.5
> 
> 

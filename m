From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 1 Jul 2016 20:50:19 +0200
Subject: [PATCH] ARM: at91/dt: sama5d2_xplained: Update the pmic node
In-Reply-To: <1466753525-4742-1-git-send-email-wenyou.yang@atmel.com>
References: <1466753525-4742-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160701185019.GF2874@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/06/2016 at 15:32:05 +0800, Wenyou Yang wrote :
> Due to introducing the new driver - ACT8945A MFD drive,
> change the pmic device node to align with the ACT8945A
> regulator and charger drivers.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 41 ++++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
Applied, thanks.

However, the subject line should have been:
ARM: dts: at91: sama5d2_xplained: Update the pmic node


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

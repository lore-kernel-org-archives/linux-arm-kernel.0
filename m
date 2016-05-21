From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 21 May 2016 10:09:07 -0700
Subject: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
In-Reply-To: <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
Message-ID: <57409633.8060605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/05/2016 14:36, Chris Brand a ?crit :
> This driver supports reset on both BCM21664 and BCM23550.
> Code is being moved from arch/arm/mach-bcm/board_bcm21664.c
> 
> Signed-off-by: Chris Brand <chris.brand@broadcom.com>

Sebastian, Dmitry, I know we are in the merge window, let me know if you
would want me to take this patch and the 5 others in the next arm-soc
pull request, or if you prefer to take this one in your own tree.

Thanks!
-- 
Florian

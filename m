From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 19 Nov 2015 15:36:14 -0800
Subject: [PATCH 0/2] ARM: dts: NSP: clean-ups and I2C support
In-Reply-To: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
References: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
Message-ID: <564E5CEE.10503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 11:55, Jon Mason wrote:
> 
> Minor changes to the Broadcom Northstar Plus device tree to make it more
> organized and clean, and adding I2C support (device tree only change
> needed for support).

Series applied, thanks Jon!

> 
> 
> Jon Mason (2):
>   ARM: dts: NSP: Device Tree clean-ups
>   ARM: dts: NSP: Add I2C support to the DT
> 
>  arch/arm/boot/dts/bcm-nsp.dtsi | 59 ++++++++++++++++++++++++------------------
>  1 file changed, 34 insertions(+), 25 deletions(-)
> 


-- 
Florian

From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 24 Apr 2018 16:15:20 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Update with current
 configuration
In-Reply-To: <20180424081528.25883-2-gregory.clement@bootlin.com>
References: <20180424081528.25883-1-gregory.clement@bootlin.com>
 <20180424081528.25883-2-gregory.clement@bootlin.com>
Message-ID: <20180424161520.304d0b73@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 24 Apr 2018 10:15:27 +0200, Gregory CLEMENT wrote:
> During time, the multi_v7_defconfig file has diverged from the one

During -> Over

> generated with make savedefconfig. Update it by simply doing a:
> 
> make savedefconfig; cp deffconfig arch/arm/configs/multi_v7_defconfig

Typo: deffconfig -> defconfig

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

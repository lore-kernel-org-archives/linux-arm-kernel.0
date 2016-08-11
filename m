From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 11 Aug 2016 10:19:42 +0200
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add efuse0 device node for
 rk3399
In-Reply-To: <1470878029-11878-4-git-send-email-finley.xiao@rock-chips.com>
References: <1470878029-11878-1-git-send-email-finley.xiao@rock-chips.com>
 <1470878029-11878-4-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1508482.TbGnezVHUZ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. August 2016, 09:13:48 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Add a efuse0 node in the device tree for the ARM64 rk3399 SoC.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

this patch adds a node for a new compatible, so to limit conflicts in the 
somewhat high-traffic rk3399, I'd like to pick this patch up myself once the 
others are deemed suitable.


Thanks
Heiko

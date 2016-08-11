From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 11 Aug 2016 10:14:03 +0200
Subject: [PATCH v2 1/4] nvmem: rockchip-efuse: update compatible strings
 for Rockchip efuse
In-Reply-To: <1470878029-11878-2-git-send-email-finley.xiao@rock-chips.com>
References: <1470878029-11878-1-git-send-email-finley.xiao@rock-chips.com>
 <1470878029-11878-2-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <21647624.nrv841C5QK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. August 2016, 09:13:46 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Rk3399-efuse is organized as 32bits by 32 one-time programmable electrical
> fuses. The efuse of earlier SoCs are organized as 32bits by 8 one-time
> programmable electrical fuses with random access interface.
> 
> Add different device tree compatible string for different SoCs to be able
> to differentiate between the two. The old binding is of course preserved,
> though deprecated.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

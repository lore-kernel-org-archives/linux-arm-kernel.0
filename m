From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 11 Aug 2016 10:21:56 +0200
Subject: [PATCH v2 4/4] nvmem: rockchip-efuse: add rk3399-efuse support
In-Reply-To: <1470878029-11878-5-git-send-email-finley.xiao@rock-chips.com>
References: <1470878029-11878-1-git-send-email-finley.xiao@rock-chips.com>
 <1470878029-11878-5-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <2505532.cfPLbvGbN0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. August 2016, 09:13:49 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> 1) the efuse timing of rk3399 is different from earlier SoCs.
> 2) rk3399-efuse is organized as 32bits by 32 one-time programmable
> electrical fuses, the efuse of earlier SoCs is organized as 32bits
> by 8 one-time programmable electrical fuses with random access interface.
> 
> This patch adds a new read function for rk3399-efuse.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

looks good now to me
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks for fixing
Heiko

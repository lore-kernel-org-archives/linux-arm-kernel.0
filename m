From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 11 Aug 2016 10:18 +0200
Subject: [PATCH v2 2/4] ARM: dts: rockchip: update compatible strings for
 Rockchip efuse
In-Reply-To: <1470878029-11878-3-git-send-email-finley.xiao@rock-chips.com>
References: <1470878029-11878-1-git-send-email-finley.xiao@rock-chips.com>
 <1470878029-11878-3-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <4317581.3Ap4cvVWdH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 11. August 2016, 09:13:47 schrieb Finlye Xiao:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

due to the renaming of the compatibles and to not introduce regressions, this 
patch should probably go through the nvmem-tree as well (instead of my 
rockchip-tree), so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

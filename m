From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 23 May 2018 12:57:38 +0200
Subject: [PATCH v3 04/13] soc: rockchip: power-domain: Fix wrong value
 when power up pd
In-Reply-To: <1527058129-10260-5-git-send-email-zhangqing@rock-chips.com>
References: <1527058129-10260-1-git-send-email-zhangqing@rock-chips.com>
 <1527058129-10260-5-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1782209.MGTIqozbO9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 23. Mai 2018, 08:48:40 CEST schrieb Elaine Zhang:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Solve the pd could only ever turn off but never turn them on again,
> If the pd registers have the writemask bits.
> 
> Fix up the code error for commit:
> 	commit 79bb17ce8edb3141339b5882e372d0ec7346217c
> 	Author: Elaine Zhang <zhangqing@rock-chips.com>
> 	Date:   Fri Dec 23 11:47:52 2016 +0800
> 
> 	soc: rockchip: power-domain: Support domain control in hiword-registers
> 
> 	New Rockchips SoCs may have their power-domain control in registers
> 	using a writemask-based access scheme (upper 16bit being the write
> 	mask). So add a DOMAIN_M type and handle this case accordingly.
> 	Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> 	Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

I've already applied that patch from v2.


Heiko

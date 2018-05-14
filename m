From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 14 May 2018 08:16:16 +0200
Subject: [PATCH v2 04/13] soc: rockchip: power-domain: Fix wrong value
 when power up pd
In-Reply-To: <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <20180514061616.GA9153@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 11:29:38AM +0800, Elaine Zhang wrote:
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
> ---
>  drivers/soc/rockchip/pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

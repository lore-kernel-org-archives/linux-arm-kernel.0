From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 02 Mar 2016 22:48:57 +0100
Subject: [PATCH 44/50] pinctrl: rockchip: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-45-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-45-git-send-email-ldewangan@nvidia.com>
Message-ID: <5977786.QpJVyEjgAu@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 24. Februar 2016, 18:46:09 schrieb Laxman Dewangan:
> Use devm_pinctrl_register() for pin control registration.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip at lists.infradead.org

looks good to me

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

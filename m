From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 18 Nov 2014 16:41:48 +0100
Subject: [PATCH] clk: rockchip: fix parent clock for rk3188 hclk_lcdc1
In-Reply-To: <1416309043-29069-1-git-send-email-julien.chauveau@neo-technologies.fr>
References: <1416309043-29069-1-git-send-email-julien.chauveau@neo-technologies.fr>
Message-ID: <3112886.9YHa130KKH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

Am Dienstag, 18. November 2014, 12:10:43 schrieb Julien CHAUVEAU:
> The parent clock for hclk_lcdc1 was set to aclk_cpu instead of hclk_cpu.
> 
> Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>

thanks for catching this. I've applied it to my clk branch for 3.19


Heiko

From: davem@davemloft.net (David Miller)
Date: Fri, 23 Oct 2015 05:48:35 -0700 (PDT)
Subject: [PATCH] drivers: net: cpsw: use module_platform_driver
In-Reply-To: <1445600472-19242-1-git-send-email-grygorii.strashko@ti.com>
References: <1445600472-19242-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20151023.054835.575367388673659421.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 23 Oct 2015 14:41:12 +0300

> There is no reasons to probe cpsw from late_initcall level
> and it's not recommended. Hence, use module_platform_driver()
> to register and probe cpsw driver from module_init() level.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied to net-next, thanks.

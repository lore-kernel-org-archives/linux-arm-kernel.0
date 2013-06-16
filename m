From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Jun 2013 05:52:48 +0900
Subject: [RFC PATCH 5/5] ARM: Samsung: Remove MIPI PHY setup code
In-Reply-To: <1371231951-1969-6-git-send-email-s.nawrocki@samsung.com>
References: <1371231951-1969-1-git-send-email-s.nawrocki@samsung.com>
 <1371231951-1969-6-git-send-email-s.nawrocki@samsung.com>
Message-ID: <51BE25A0.6050202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/13 02:45, Sylwester Nawrocki wrote:
> Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
> DPHYs so we can remove now unused code at arch/arm/plat-samsung.

If so, sounds good :)

> In case there is any board file for S5PV210 platforms using MIPI
> CSIS/DSIM (not any upstream currently) it should use the generic
> PHY API to bind the PHYs to respective PHY consumer drivers.

To be honest, I didn't test this on boards but if the working is fine, 
please go ahead without RFC.

Thanks,
- Kukjin

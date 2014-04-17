From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 17 Apr 2014 16:52:44 -0400
Subject: [PATCH V2 03/19] bus: omap_l3_noc: remove iclk from omap_l3 struct
In-Reply-To: <1397767775-10965-4-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
 <1397767775-10965-4-git-send-email-nm@ti.com>
Message-ID: <53503F1C.9040309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 April 2014 04:49 PM, Nishanth Menon wrote:
> we do not use iclk directly anymore. And, even if we had to, we
> should be using pm_runtime APIs to do the same to be completely SoC
> independent.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

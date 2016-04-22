From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Fri, 22 Apr 2016 12:25:29 +0530
Subject: [PATCH net v2 0/3] drivers: net: cpsw: phy-handle fixes
In-Reply-To: <1461261035-5578-1-git-send-email-drivshin.allworx@gmail.com>
References: <1461261035-5578-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <5719CAE1.40801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 11:20 PM, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> The first patch fixes a bug that makes dual_emac mode break if
> either slave uses the phy-handle property in the devicetree.
> 
> The second patch fixes some cosmetic problems with error messages,
> and also makes the binding documentation more explicit.
> 
> The third patch cleans up the fixed-link case to work like
> the now-fixed phy-handle case.
> 
> I have tested on the following hardware configurations:
>  - (EVMSK) dual emac, phy_id property in both slaves
>  - (EVMSK) dual emac, phy-handle property in both slaves
>  - (BeagleBoneBlack) single emac, phy_id property
>  - (custom) single emac, fixed-link subnode
> 
> Nicolas Chauvet reported testing on an HP t410 (dm8148).
> 
> Markus Brunner reported testing v1 on the following [1]:
>  - emac0 with phy_id and emac1 with fixed phy
>  - emac0 with phy-handle and emac1 with fixed phy
>  - emac0 with fixed phy and emac1 with fixed phy
> 
> 

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N

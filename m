From: mugunthanvnm@ti.com (Mugunthan V N)
Date: Thu, 28 Apr 2016 15:43:28 +0530
Subject: [PATCH net v3 4/5] dt: cpsw: phy-handle, phy_id, and fixed-link
 are mutually exclusive
In-Reply-To: <1461807767-4563-1-git-send-email-drivshin.allworx@gmail.com>
References: <1461805808-4102-1-git-send-email-drivshin.allworx@gmail.com>
 <1461807767-4563-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <5721E248.6040106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2016 07:12 AM, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> The phy-handle, phy_id, and fixed-link properties are mutually exclusive,
> and only one need be specified. Make this clear in the binding doc.
> 
> Also mark the phy_id property as deprecated, as phy-handle should be
> used instead.
> 
> Signed-off-by: David Rivshin <drivshin@allworx.com>

Reviewed-by: Mugunthan V N <mugunthanvnm@ti.com>

Regards
Mugunthan V N

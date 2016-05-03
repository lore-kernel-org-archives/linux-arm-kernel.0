From: robh@kernel.org (Rob Herring)
Date: Tue, 3 May 2016 11:14:01 -0500
Subject: [PATCH net v3 4/5] dt: cpsw: phy-handle, phy_id, and fixed-link
 are mutually exclusive
In-Reply-To: <1461807767-4563-1-git-send-email-drivshin.allworx@gmail.com>
References: <1461805808-4102-1-git-send-email-drivshin.allworx@gmail.com>
 <1461807767-4563-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <20160503161401.GA32607@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 09:42:47PM -0400, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
> 
> The phy-handle, phy_id, and fixed-link properties are mutually exclusive,
> and only one need be specified. Make this clear in the binding doc.
> 
> Also mark the phy_id property as deprecated, as phy-handle should be
> used instead.
> 
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> ---
> 
> Changes since v2 [1]:
> - split from previous patch 2
> - marked the phy_id property as deprecated [3]
> - removed Rob Herring's Acked-by due to above change
> 
> Changes since v1 [2]:
> - Rebased (no conflicts)
> - Added Tested-by from Nicolas Chauvet
> - Added Acked-by from Rob Herring for the binding change
> 
> [1] http://patchwork.ozlabs.org/patch/613260/
> [2] http://patchwork.ozlabs.org/patch/560324/
> [3] https://lkml.org/lkml/2016/4/22/494
> 
> 
>  Documentation/devicetree/bindings/net/cpsw.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

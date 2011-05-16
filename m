From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 16 May 2011 10:11:57 +0300 (EEST)
Subject: [PATCH] omap: iommu: fix pte attributes for super section
In-Reply-To: <BANLkTinqPkftv7KmghCCBpEdULh0cNivHg@mail.gmail.com>
References: <BANLkTinqPkftv7KmghCCBpEdULh0cNivHg@mail.gmail.com>
Message-ID: <20110516.101157.344277473342871979.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "ext Anna, Suman" <s-anna@ti.com>
Subject: [PATCH] omap: iommu: fix pte attributes for super section
Date: Tue, 10 May 2011 10:25:17 -0700

> From 5796d8d8a0ea5aee342b78ca6ead229971cff6c5 Mon Sep 17 00:00:00 2001
> From: Suman Anna <s-anna@ti.com>
> Date: Wed, 4 May 2011 17:45:37 -0500
> Subject: [PATCH] omap: iommu: fix pte attributes for super section
> 
> The PTE programming causes a 16MB entry to be interpreted
> as a 4K entry because of the bitwise check, and therefore does
> not set the attributes properly in the first-level descriptor
> table. The bitwise check has been replaced appropriately.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Thanks, checked with OMAP2/3 TRM.

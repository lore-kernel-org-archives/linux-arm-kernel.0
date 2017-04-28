From: tj@kernel.org (Tejun Heo)
Date: Fri, 28 Apr 2017 17:20:06 -0400
Subject: [PATCH v4 05/21] lib: fix Devres devm_ioremap_* offset parameter
 kerneldoc description
In-Reply-To: <20170419164913.19674-6-lorenzo.pieralisi@arm.com>
References: <20170419164913.19674-1-lorenzo.pieralisi@arm.com>
 <20170419164913.19674-6-lorenzo.pieralisi@arm.com>
Message-ID: <20170428212006.GD22354@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 05:48:54PM +0100, Lorenzo Pieralisi wrote:
> The offset parameter in Devres devm_ioremap_* functions kerneldoc
> entries is erroneously defined as BUS offset whereas it is actually
> a resource address.
> 
> Since it is actually misleading, fix the Devres devm_ioremap_* offset
> parameter kerneldoc entry by replacing BUS offset with a more
> suitable description (ie Resource address).
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

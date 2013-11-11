From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Nov 2013 12:23:25 +0000
Subject: [PATCH] ARM: rename ioremap_cached to ioremap_cache
In-Reply-To: <1383945956-27788-1-git-send-email-robherring2@gmail.com>
References: <1383945956-27788-1-git-send-email-robherring2@gmail.com>
Message-ID: <20131111122324.GC29572@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 08, 2013 at 09:25:56PM +0000, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> ioremap_cache is more aligned with other architectures. There are only
> 2 users of this in the kernel: pxa2xx-flash and Xen.

I missed Xen here. I agree with this patch, ioremap_cache() is more
widely used.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

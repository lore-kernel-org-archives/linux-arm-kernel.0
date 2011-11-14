From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 14 Nov 2011 01:32:03 +0100
Subject: [PATCH] mfd: add #ifdef CONFIG_DEBUG_FS guard for
 ab8500_debug_resources
In-Reply-To: <1320890178.13074.1.camel@phoenix>
References: <1320890178.13074.1.camel@phoenix>
Message-ID: <20111114003203.GK22218@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Thu, Nov 10, 2011 at 09:56:18AM +0800, Axel Lin wrote:
> Fix below build warning if CONFIG_DEBUG_FS is disabled.
> 
>   CC      drivers/mfd/ab8500-core.o
> drivers/mfd/ab8500-core.c:623: warning: 'ab8500_debug_resources' defined but not used
> 
Thanks for the fix, I applied this one to my for-linus branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

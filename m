From: gadiyar@ti.com (Gadiyar, Anand)
Date: Wed, 24 Mar 2010 17:13:02 +0530
Subject: [PATCH 00/14] omap DEBUG_LL and multiboot changes for 2.6.34
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032221AAC6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote:
> These patches clean up the DEBUG_LL code for mach-omap1 and mach-omap2
> and then makes multiboot work for mach-omap2.
> 
> Note that these patches currently allow only multiboot for 2420 + 36xx.
> Adding 2430 and omap4 needs further work.
> 

Tony,

Purely out of curiosity (triggered by someone asking about 2430SDP on
the list), do you know what it'll take to get mutli-boot working on 2430?

I'm not familiar with those boards of course - does anyone still have
them around?

Thanks,
Anand

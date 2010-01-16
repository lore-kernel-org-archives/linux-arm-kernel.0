From: tony@atomide.com (Tony Lindgren)
Date: Sat, 16 Jan 2010 11:20:30 -0800
Subject: [PATCH 2/4] omap: Make uncompress code and DEBUG_LL code generic
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F902C@dbde02.ent.ti.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013515.10065.30649.stgit@baageli.muru.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C06F902C@dbde02.ent.ti.com>
Message-ID: <20100116192029.GJ10318@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100116 03:02]:

<snip>

> Can you please add add OMAP4 UART3 case as well here using 
> "OMAP4UART3". 

Sure.
 
> Attached patch fixes UART3 support for OMAP4 on top of your patches. Tested 
> this on OMAP4430 SDP. You can fold this patch if you like

Thanks will test. And thanks for testing. Note that once the
issues Russell pointed out are solved, we should also easily
be able to support the external uart on Zoom boards for
DEBUG_LL.

Regards,

Tony

From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 14 Dec 2009 22:43:16 -0700 (MST)
Subject: [PATCH 0/5] OMAP4 Power Domain Framework Support
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC2402B9@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02BC14194C@dbde02.ent.ti.com>
	<alpine.DEB.2.00.0912141628300.12561@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BC2402B9@dbde02.ent.ti.com>
Message-ID: <alpine.DEB.2.00.0912142240260.12561@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhijit,

On Tue, 15 Dec 2009, Pagare, Abhijit wrote:

> 	There is one Fix patch for OMAP3 on top of which these patches 
> should go in cleanly. I will post the fix patch and the rebased and 
> tested patch-set soon.

thanks.  One other thing that I noticed: in the first powerdomain patch, 
in arch/arm/plat-omap/include/plat/cpu.h, in struct omap_chip_id, the 'oc' 
field needs to be a u16, rather than a u8.


- Paul

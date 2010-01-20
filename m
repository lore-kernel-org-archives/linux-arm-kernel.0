From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 20 Jan 2010 12:52:15 +0530
Subject: [PATCH] OMAP CPU ID: fix OMAP4 build failure
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
References: <alpine.DEB.2.00.1001191412130.3977@utopia.booyaka.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C07CC987@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C07CC9A7@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Abhijit,

<snip>

> I had used this flag earlier as there was nothing fixed as to name it as ES1 that time. So now it can
> be migrated from CHIP_IS_OMAP4430 to CHIP_IS_OMAP4430ES1. I think CHIP_IS_OMAP4430 would be redundant
> in that case and should be removed. A patch would be essential to take care of that in the places
> where it is used. If you feel the same I can send a patch for fixing this.
> 

Tony has already created the patch. Please use that and test it on OMAP4.

Regards,
Santosh

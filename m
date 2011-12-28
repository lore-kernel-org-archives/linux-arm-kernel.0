From: aspotashev@emcraft.com (Alexander Potashev)
Date: Wed, 28 Dec 2011 14:51:44 +0400
Subject: Renaming MACH_TYPE_KINETIS_K60 into MACH_TYPE_KINETIS
In-Reply-To: <201112281100.35209.marek.vasut@gmail.com>
References: <1325065882.1584.153.camel@skywanderer.emcraft.com>
 <201112281100.35209.marek.vasut@gmail.com>
Message-ID: <1325069504.1584.160.camel@skywanderer.emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-12-28 at 11:00 +0100, Marek Vasut wrote:
> If you use FDT, you won't need machine ID at all. 

Hi Marek,

You are right, but we have not used FDT for any of our ARM Linux ports
yet (consistency matters.) If we switch to FDT now, a lot of code will
need to be rewritten.

That is why I would prefer to stay with machine type-based
identification.


-- 
Regards,
Alexander

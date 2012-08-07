From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 00:38:03 -0700
Subject: [PATCH] OMAP: remove unused parameter arch_id from uncompress.h
In-Reply-To: <20120714204952.GA4798@raptus.dandreoli.com>
References: <20120714204952.GA4798@raptus.dandreoli.com>
Message-ID: <20120807073803.GP11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Domenico Andreoli <cavokz@gmail.com> [120714 13:54]:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> There is not point in having arch_id as parameter of __arch_decomp_setup(),
> nothing in it uses arch_id. The machine id is already exported (and used)
> with symbol __machine_arch_type as per mach-types.h.
> 
> Removing the pointless macro as well.

Thanks applying into fixes.

Tony

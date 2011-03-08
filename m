From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Mar 2011 15:11:49 -0800
Subject: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1 configs
In-Reply-To: <alpine.DEB.2.00.1103071933350.10981@utopia.booyaka.com>
References: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
	<20110307163047.a65c51d2.jhnikula@gmail.com>
	<alpine.DEB.2.00.1103071933350.10981@utopia.booyaka.com>
Message-ID: <20110308231149.GG26463@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110307 18:32]:
> On Mon, 7 Mar 2011, Jarkko Nikula wrote:
> 
> > omapxxx_mcbsp_res_0 doesn't look the best here in readability point of
> > view but provides the smallest fix as no need to rename array and
> > modify the _RES_SZ and _COUNT macros. So this fix is needed here and a
> > small readability update can be done later.
> > 
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Thanks Jarkko.  For what it's worth, I agree it's an ugly patch.

Applying.

Tony

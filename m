From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Mar 2011 19:34:09 -0700 (MST)
Subject: [PATCH] OMAP1: McBSP: fix build break for non-multi-OMAP1 configs
In-Reply-To: <20110307163047.a65c51d2.jhnikula@gmail.com>
References: <alpine.DEB.2.00.1103041535150.10981@utopia.booyaka.com>
	<20110307163047.a65c51d2.jhnikula@gmail.com>
Message-ID: <alpine.DEB.2.00.1103071933350.10981@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Mar 2011, Jarkko Nikula wrote:

> omapxxx_mcbsp_res_0 doesn't look the best here in readability point of
> view but provides the smallest fix as no need to rename array and
> modify the _RES_SZ and _COUNT macros. So this fix is needed here and a
> small readability update can be done later.
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Thanks Jarkko.  For what it's worth, I agree it's an ugly patch.


- Paul

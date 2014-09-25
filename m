From: scottwood@freescale.com (Scott Wood)
Date: Thu, 25 Sep 2014 17:04:56 -0500
Subject: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
In-Reply-To: <20140925213959.19023.80648@quantum>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <20140925213959.19023.80648@quantum>
Message-ID: <1411682696.13320.207.camel@snotra.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-09-25 at 14:39 -0700, Mike Turquette wrote:
> Quoting Jingchang Lu (2014-09-22 23:46:46)
> > +CLK_OF_DECLARE(qoriq_core_pll_v1, "fsl,qoriq-core-pll-1.0", core_pll_init);
> > +CLK_OF_DECLARE(qoriq_core_pll_v2, "fsl,qoriq-core-pll-2.0", core_pll_init);
> > +CLK_OF_DECLARE(qoriq_core_mux_v1, "fsl,qoriq-core-mux-1.0", core_mux_init);
> > +CLK_OF_DECLARE(qoriq_core_mux_v2, "fsl,qoriq-core-mux-2.0", core_mux_init);
> 
> Is there binding documentation for these compatibles?

Documentation/devicetree/bindings/clock/qoriq-clock.txt

-Scott

From: bayi.cheng@mediatek.com (bayi.cheng)
Date: Tue, 15 Sep 2015 14:53:41 +0800
Subject: [PATCH 1/3] doc: dt: add documentation for Mediatek spi-nor
 controller
In-Reply-To: <20150911214907.GE11487@google.com>
References: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
 <1441705796-11365-2-git-send-email-bayi.cheng@mediatek.com>
 <20150911214907.GE11487@google.com>
Message-ID: <1442300021.27250.10.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-11 at 14:49 -0700, Brian Norris wrote:
> One more thing:
> 
> On Tue, Sep 08, 2015 at 05:49:54PM +0800, Bayi Cheng wrote:
> > +- clocks: spi nor source clock
> 
> ^^ you only list one clock here
> 
Ok, I will add other clocks
> > +- clock-names: "spi_clk", "axi_clk", "mux_clk", "sf_clk"
> 
> But you have 4 names here.
> 
> ...
> > +	clocks = <&pericfg CLK_PERI_SPI>,
> > +		 <&topckgen CLK_TOP_AXI_SEL>,
> > +		 <&topckgen CLK_TOP_UNIVPLL2_D8>,
> > +		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
> 
> And you provide 4 clocks.
> 
> > +	clock-names = "spi_clk", "axi_clk", "mux_clk", "sf_clk";
> 
> Please list all 4 under the "clocks" property, not just under the
> "clock-names" property.
> 
OK,  Thanks for your remind!
> Brian

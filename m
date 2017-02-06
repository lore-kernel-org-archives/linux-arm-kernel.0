From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 6 Feb 2017 08:45:44 +0100
Subject: [PATCH v2 2/2] arm: dts: mt2701: add nor flash node
In-Reply-To: <1486267249.10417.9.camel@mhfsdcap03>
References: <1485315515-29942-1-git-send-email-guochun.mao@mediatek.com>
 <1485315515-29942-3-git-send-email-guochun.mao@mediatek.com>
 <1486267249.10417.9.camel@mhfsdcap03>
Message-ID: <20170206084544.24878633@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guochun,

On Sun, 5 Feb 2017 12:00:49 +0800
Guochun Mao <guochun.mao@mediatek.com> wrote:


> >  
> > +	nor_flash: spi at 11014000 {
> > +		compatible = "mediatek,mt2701-nor",
> > +			     "mediatek,mt8173-nor";
> > +		reg = <0 0x11014000 0 0xe0>;
> > +		clocks = <&pericfg CLK_PERI_FLASH>,
> > +			 <&topckgen CLK_TOP_FLASH_SEL>;
> > +		clock-names = "spi", "sf";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		status = "disabled";
> > +	};
> > +
> >  	mmsys: syscon at 14000000 {
> >  		compatible = "mediatek,mt2701-mmsys", "syscon";
> >  		reg = <0 0x14000000 0 0x1000>;  
> 
> Hi,
> mtk-quadspi.txt had been updated as suggested.
> Is there suggestion about this patch?

It should probably go through the Mediatek tree. Matthias, any opinion?

Regards,

Boris

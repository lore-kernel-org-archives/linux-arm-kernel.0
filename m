From: jamesjj.liao@mediatek.com (James Liao)
Date: Mon, 15 Jun 2015 10:10:24 +0800
Subject: [PATCH 4/5] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <5809360.66NP4oPW1R@ubix>
References: <1432192376-6712-1-git-send-email-jamesjj.liao@mediatek.com>
 <1432192376-6712-5-git-send-email-jamesjj.liao@mediatek.com>
 <5809360.66NP4oPW1R@ubix>
Message-ID: <1434334224.18080.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-06-12 at 19:09 +0200, Matthias Brugger wrote:
> On Thursday, May 21, 2015 03:12:55 PM James Liao wrote:
> > +
> > +static struct mtk_gate_regs venclt_cg_regs = {
> > +	.set_ofs = 0x0004,
> > +	.clr_ofs = 0x0008,
> > +	.sta_ofs = 0x0000,
> > +};
> 
> 
> The register for imagesys, vencsys and vencltsys have all the same offset.
> We could use just one struct for all of them. 

OK. I'll merge them in next patch.


Best regards,

James

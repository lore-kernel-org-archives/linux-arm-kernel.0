From: flora.fu@mediatek.com (Flora Fu)
Date: Mon, 1 Dec 2014 11:19:25 +0800
Subject: [PATCH v2 8/8] ARM: dts: mt8135: Add support for MT6397 regulator
In-Reply-To: <20141128153008.GS7712@sirena.org.uk>
References: <1417146874-5232-1-git-send-email-flora.fu@mediatek.com>
 <1417146874-5232-9-git-send-email-flora.fu@mediatek.com>
 <20141128153008.GS7712@sirena.org.uk>
Message-ID: <1417403967.9547.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark, 

On Fri, 2014-11-28 at 15:30 +0000, Mark Brown wrote: 
> On Fri, Nov 28, 2014 at 11:54:34AM +0800, Flora Fu wrote:
> 
> > Add device tree for MT6397 regulators in mt8135.dtsi.
> > 
> > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> > ---
> >  arch/arm/boot/dts/mt8135.dtsi | 192 ++++++++++++++++++++++++++++++++++++++++++
> 
> This appears to be the DT fragment for a SoC but you are defining the
> system integration for the PMIC.  That's bad, the PMIC is a separate
> device so should be hooked up by the board using it.  If there's common
> elements from a reference design they should be in their own .dtsi.
> 

Do you mean that we should add a mt6397.dtsi and include it from
mt8135.dtsi? For board specific, update them in mt8135.dtsi? 

Thanks,
Flora

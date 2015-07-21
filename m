From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Tue, 21 Jul 2015 17:46:53 +0800
Subject: [PATCH 1/2] dt-bindings: Add document for MT6311 regulator
In-Reply-To: <20150720172828.GG11162@sirena.org.uk>
References: <1437377793-31558-1-git-send-email-henryc.chen@mediatek.com>
 <1437377793-31558-2-git-send-email-henryc.chen@mediatek.com>
 <20150720172828.GG11162@sirena.org.uk>
Message-ID: <1437472013.30329.53.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-20 at 18:28 +0100, Mark Brown wrote:
> On Mon, Jul 20, 2015 at 03:36:32PM +0800, Henry Chen wrote:
> 
> > +Required properties:
> > +- compatible: "mediatek,mt6311-regulator"
> > +- mt6311regulator: List of regulators provided by this controller. It is named
> > +  to VDVFS and VBIASN.
> 
> Why this weird property name?  It looks like it might just be a typo and
> should just be "regulator"?
Yes, it should be "regulators".

> 
> Please use subject lines reflecting the style for the subsystem, it
> helps people find patches that are relevant to them.

Ok.

Thanks,
Henry

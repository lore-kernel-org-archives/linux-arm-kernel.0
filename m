From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 24 Mar 2017 20:01:48 +0300
Subject: [PATCH 1/3] crypto: hw_random - Add new Exynos RNG driver
In-Reply-To: <87677624.EBdhaJY1KM@amdc3058>
References: <20170324142446.31129-1-krzk@kernel.org>
 <9265537.P6AeF50kg8@amdc3058>
 <20170324161934.kc6g36nazr3y32kp@kozik-lap>
 <CGME20170324164544epcas1p353b2eba5ecb6d5f7a69049c5ba9d667e@epcas1p3.samsung.com>
 <87677624.EBdhaJY1KM@amdc3058>
Message-ID: <20170324170148.ew7ozpt5jfwdx5yn@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 05:45:41PM +0100, Bartlomiej Zolnierkiewicz wrote:
> > > > And I think the probe might be called twice, for example in case of
> > > > mistake in DTB.
> > > 
> > > Even if this is possible resource allocation code in the driver will
> > > take take care of handling it just fine,
> > 
> > Indeed, the devm_ioremap_resource() solves the case. I can drop the
> > check then.
> 
> Looking on this a bit more it seems that devm_ioremap_resource() will
> not cover all mistakes (using compatible by mistake in some other DTB
> node).
> 
> Leave the check, I take my objection back.

Great! Thanks for feedback.

Best regards,
Krzysztof

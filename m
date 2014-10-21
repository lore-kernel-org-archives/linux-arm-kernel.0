From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Oct 2014 14:24:58 +0200
Subject: [PATCH v2 4/4] ARM: dts: exynos4412-trats: Add suspend
 configuration for max77686 regulators
In-Reply-To: <54464BC1.40201@collabora.co.uk>
References: <1413890597-31037-1-git-send-email-k.kozlowski@samsung.com>
 <1413890597-31037-5-git-send-email-k.kozlowski@samsung.com>
 <54464BC1.40201@collabora.co.uk>
Message-ID: <1413894298.31665.10.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On wto, 2014-10-21 at 14:04 +0200, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/21/2014 01:23 PM, Krzysztof Kozlowski wrote:
> > Add suspend to RAM configuration for max77686 regulators. Some LDOs and
> > bucks are disabled. This reduces energy consumption during S2R,
> > approximately from 17 mA to 9 mA.
> > 
> > Additionally remove old and not supported bindings:
> >  - regulator-mem-off
> >  - regulator-mem-idle
> >  - regulator-mem-on
> > The max77686 driver does not parse them and they are not documented
> > anywere.
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos4412-trats2.dts | 72 +++++++++++++++++++--------------
> >  1 file changed, 42 insertions(+), 30 deletions(-)
> > 
> 
> I'm not familiar with the board but the change looks good to me assuming each
> regulator is doing the right thing.
> 
> I already gave you my Reviewed-by for the previous version but was not carried:
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Thanks! I didn't add your review-by-tag because changes in the patch.

Best regards,
Krzysztof


> 
> Best regards,
> Javier

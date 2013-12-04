From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 04 Dec 2013 12:03:31 +0100
Subject: [PATCH v6 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <529F0B75.5040004@samsung.com>
References: <1386153615-25456-1-git-send-email-k.kozlowski@samsung.com>
 <1386153615-25456-4-git-send-email-k.kozlowski@samsung.com>
 <529F08DD.2090005@samsung.com> <1386154579.25938.2.camel@AMDC1943>
 <529F0B75.5040004@samsung.com>
Message-ID: <1386155011.25938.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-04 at 20:01 +0900, Chanwoo Choi wrote:
> On 12/04/2013 07:56 PM, Krzysztof Kozlowski wrote:
> > On Wed, 2013-12-04 at 19:50 +0900, Chanwoo Choi wrote:
(...)
> >>
> >> I prefer to add dt data about max14577-muic on following:
> >> If extcon consumer driver need to use muic device, dts should provide following dt data.
> >>
> >> 		muic: max14577-muic {
> >> 			compatible = "maxim, max14577-muic";
> >> 		};
> >>> +	};
> >>>
> >> For example,
> >> If fuel-gauge want to use extcon subsystem, dt data of fuel-gauge add 'extcon' property as following:
> >>
> >> 	fuel-gague@ {
> >> 		compatible = "...";
> >> 		extcon = <&muic>;
> >> 	}
> >>
> > Hi,
> > 
> > The extcon driver itself does not use the binding. It is only needed for
> > consumers. Is it a common practice to add to documentation such notice
> > for consumers only?
> 
> As you comment, It is only for extcon consumer.
> But extcon provider driver always is operated with extcon consumer driver.
> If dts file don't support upper dt data about extcon provider driver,
> all of extcon consumer drivers could not use extcon subsystem.
> 
> I thinks it is common dt data for muic device.

OK, I'll add it.

Best regards,
Krzysztof

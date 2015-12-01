From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 16:11:40 +0100
Subject: [PATCH 02/10] ASoC: samsung/smartq: use dynamic registration
In-Reply-To: <565CE8B8.3090903@samsung.com>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
 <1448467615-447097-3-git-send-email-arnd@arndb.de>
 <565CE8B8.3090903@samsung.com>
Message-ID: <1538856.GqqaeJI10z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 09:24:24 Krzysztof Kozlowski wrote:
> > +static struct platform_driver smartq_driver = {
> > +     .driver = {
> > +             .name = "smartq-audio",
> > +             .owner = THIS_MODULE,
> 
> The owner should not be needed (coccicheck should also complain). Rest
> looks good, so:

Good catch, fixed now!
 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

thanks,

	Arnd

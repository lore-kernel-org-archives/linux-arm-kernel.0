From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Mar 2018 15:13:54 +0100
Subject: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I
 laptop
In-Reply-To: <E1exwhF-0000Qw-4g@stardust.g4.wien.funkfeuer.at>
References: <20180315162510.11669-1-harald@ccbib.org>
 <20180315162510.11669-6-harald@ccbib.org>
 <20180318202251.5gpv6sblfr4edxmj@flea>
 <E1exwhF-0000Qw-4g@stardust.g4.wien.funkfeuer.at>
Message-ID: <20180320141353.zmzq4e5652rsp4ye@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 04:27:36PM +0100, Harald Geyer wrote:
> > together with all the patches but the
> > PWM (so I had to drop the backlight node as well).
> >
> > Please coordinate with Andre about who should send the PWM support.
> 
> Seems the patch got broken because only the backlight node but not the
> pwm node was removed. Anyway, since Andre has already sent an updated
> version of his series, maybe just revert the broken patch, merge his
> series and then apply the original teres-i patch again?

Unfortunately, there's dependencies on the PWM driver itself, and the
maintainer hasn't replied yet.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

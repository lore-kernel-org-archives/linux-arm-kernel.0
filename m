From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 13 Apr 2012 16:27:10 +0100
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <4F88434C.9010709@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <1334328122.27644.15.camel@hornet> <201204131451.10638.arnd@arndb.de>
 <4F883E40.6000905@linaro.org> <1334329500.27644.18.camel@hornet>
 <4F88434C.9010709@linaro.org>
Message-ID: <1334330830.27644.19.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-13 at 16:16 +0100, Lee Jones wrote:
> Because in it's current state, gpio-nomadik doesn't know how to decode 
> any provided flags and phandles don't work yet, hence the IRQ request 
> really is just a number in this case. In a latter patch-set I provide 
> the GPIO driver with said bindings and swap the simple integer format 
> for one which is more in keeping with the DT format e.g. <32> becomes 
> <&gpio1 1 0x4> for instance.
> 
> This patch does function perfectly well the way it is and provides no 
> breakage. I'm aiming for both patch-sets to be sucked into the v3.5 
> merge window in any case, so all functionality will be provided at -rc1. 
> Only the bleeding edge, hardcore, kernel developers who use the 
> gpio-nomadik driver (so, just me and Linus Walleij then :D ) will ever 
> use this code as-is.

I see, fine by me.

Cheers!

Pawe?

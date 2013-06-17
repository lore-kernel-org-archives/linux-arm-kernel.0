From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 00:34:12 -0700
Subject: IGEPv2 audio problem
In-Reply-To: <51BDAD7F.8090303@collabora.co.uk>
References: <20130616135208.3f124c2c@skate> <51BDAD7F.8090303@collabora.co.uk>
Message-ID: <20130617073411.GD4465@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130616 05:26]:
> 
> I can take a look to this but I don't know if Tony is still accepting bugfixes
> for board files.

Critical fixes yes, but let's plan on making omap3 also DT only for v3.12
merge window. With the patches posted recently I've verified that ret-idle
and off-idle work for omap3. So only board related device configuration and
some driver work remains. And we can of course still initialize some platform
data too where needed.
 
> twl4030 based audio should already work with DT as far as I know.

Yes I think so.

Regards,

Tony

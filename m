From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 20 May 2016 11:28:02 +0200
Subject: [PATCH 1/3] reset: Add support for the Amlogic Meson GXBB Reset
 Controller
In-Reply-To: <573ED483.10101@baylibre.com>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
 <20160520090448.GA19888@mephisto> <573ED483.10101@baylibre.com>
Message-ID: <1463736482.4322.32.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 20.05.2016, 11:10 +0200 schrieb Neil Armstrong:
[...]
> >> +module_platform_driver(meson_gxbb_reset_driver);
> > 
> > No MODULE_AUTHOR, MODULE_LICENSE, etc... ?
> 
> What is the MODULE_LICENCE format for dual licensing ?

"Dual BSD/GPL"

regards
Philipp

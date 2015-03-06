From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 Mar 2015 19:50:33 +0000
Subject: [PATCH v2] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040
 dependency
In-Reply-To: <2707228.SKhEXovzW4@wuerfel>
References: <22890811.0MuvZ4MxOU@wuerfel> <54EDEAE3.6080605@ti.com>
 <2707228.SKhEXovzW4@wuerfel>
Message-ID: <20150306195032.GV21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:42:12PM +0100, Arnd Bergmann wrote:
> The change to enable OMAP5 support on this platform was a little too
> eager in adding a 'select' for a particular clock driver that might
> not be enabled in all configurations, which in turn leads to a build
> error:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150306/b52e539d/attachment-0001.sig>

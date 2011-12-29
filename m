From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Dec 2011 01:56:40 +0000
Subject: [PATCH v4] s3c/s3c24xx: arm: leds: Make s3c24xx LEDS driver
 use gpiolib. Fix error disabling pull during probe.
In-Reply-To: <4EFB851F.9080805@solonet.org.ua>
References: <4EE7E0E7.1020802@solonet.org.ua>
 <063a01ccbfac$498513c0$dc8f3b40$%kim@samsung.com>
 <4EFB851F.9080805@solonet.org.ua>
Message-ID: <20111229015640.GB4839@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 11:07:43PM +0200, Denis Kuzmenko wrote:
> On 12/21/2011 08:46 AM, Kukjin Kim wrote:
> > Denis Kuzmenko wrote:

> >> Make s3c24xx LEDS driver use gpiolib. Fix error disabling pull during
> >> probe.

> >> Signed-off-by: Denis Kuzmenko <linux@solonet.org.ua>

> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>

> > Richard, I think, this should be handled in your tree.

> ping Richard

Take a look at the git logs - Richard hasn't been actively maintaining a
tree for the LEDs for some time now.

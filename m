From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 9 Apr 2015 13:29:43 +0200
Subject: [PATCHv7] media: i2c/adp1653: Devicetree support for adp1653
In-Reply-To: <20150409091017.GA4526@earth>
References: <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd> <20150409091017.GA4526@earth>
Message-ID: <20150409112943.GA31173@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-04-09 11:10:17, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> > [...]
> > +#include <linux/of_gpio.h>
> > +#include <linux/gpio.h>
> > [...]
> 
> This should probably be
> 
> #include <linux/of.h>
> #include <linux/gpio/consumer.h>

And I thought people would only bikesched paint on the
Documentation. Sakari, feel free to change that, but a) I don't see
why Sebastian's version is better and b) am pretty sure there is about
infinite number of possibilities there.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

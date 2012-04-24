From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 24 Apr 2012 15:04:28 +0200
Subject: device-tree vs gpio-leds gpio_blink_set
In-Reply-To: <20120424123639.GC13747@opensource.wolfsonmicro.com>
References: <20120423072745.678323582@rtp-net.org>
 <201204231122.43481.arnd@arndb.de>
 <20120423174924.GA457@sirena.org.uk>
 <CACRpkdZ4RSiqrHU60auvCx9xxZp5CQQzjis+Xz6EVMA+7-8_eg@mail.gmail.com>
 <20120424123639.GC13747@opensource.wolfsonmicro.com>
Message-ID: <20120424130428.GA26784@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mark Brown wrote:
> On Tue, Apr 24, 2012 at 02:24:16PM +0200, Linus Walleij wrote:
> > So this would be something that gets to be modeled in the
> > PWM subsystem, but there is no such thing (I know Sascha et
> > al was working on that at one point.)
> 
> Thierry took over the work and last time I saw it things looked like
> they were pretty much ready for merge, I'd really expect to see the code
> in 3.5 based on the previous state (in fact I was pretty surprised 

I posted a couple of patches about a week ago that are required to build !OF
configurations. They still need to be acked by Grant or Rob, though.

	http://lists.ozlabs.org/pipermail/devicetree-discuss/2012-April/014687.html
	http://lists.ozlabs.org/pipermail/devicetree-discuss/2012-April/014688.html

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120424/9209da77/attachment.sig>

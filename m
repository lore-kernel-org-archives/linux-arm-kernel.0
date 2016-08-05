From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 5 Aug 2016 21:58:09 +0200
Subject: [RFC] User-defined leds
In-Reply-To: <8db4e308-ae2f-ee8a-d570-cd751c4f0269@lechnology.com>
References: <57965C15.1070705@lechnology.com>
 <DB74DD94-7737-4F06-BD35-D698A65E30AD@holtmann.org>
 <20160805195130.GA26694@amd>
 <8db4e308-ae2f-ee8a-d570-cd751c4f0269@lechnology.com>
Message-ID: <20160805195809.GA28410@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2016-08-05 14:54:33, David Lechner wrote:
> On 08/05/2016 02:51 PM, Pavel Machek wrote:
> >
> >Could the device tree be used to bind LED driver to otherwise unused
> >gpio?
> 
> There is already a leds-gpio driver that does this.
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/leds/leds-gpio.txt

Yeah, I know, that's why I suggested it :-).

What might be missing: simple way to attach leds-gpio driver to
hardware on non-devicetree machines, and perhaps teaching leds-gpio
special gpio value "no gpio" meaning ... that hardware is not actually
updated.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

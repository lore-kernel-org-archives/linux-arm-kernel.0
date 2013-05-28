From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 28 May 2013 15:47:49 +0200
Subject: [PATCHv2 0/3] Add G762/G763 PWM fan controller
In-Reply-To: <20130528122940.GA29012@roeck-us.net>
References: <cover.1369687670.git.arno@natisbad.org>
 <152190814.eApXVbVBPA@wuerfel> <87li6z2yxj.fsf@natisbad.org>
 <20130528111921.GD11547@mithrandir>
 <20130528122940.GA29012@roeck-us.net>
Message-ID: <20130528134734.GA12585@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 05:29:40AM -0700, Guenter Roeck wrote:
> On Tue, May 28, 2013 at 01:19:23PM +0200, Thierry Reding wrote:
> > On Tue, May 28, 2013 at 12:15:04PM +0200, Arnaud Ebalard wrote:
> > > Hi Arnd,
> > > 
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > > 
> > > > On Tuesday 28 May 2013 00:02:29 Arnaud Ebalard wrote:
> > > >> 
> > > >> This series adds support for GMT G762/G763. This work is based on a
> > > >> basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
> > > >> NAS. Updates have been performed to run on recent kernels. Support has
> > > >> been completed and additional features added: ability to configure
> > > >> various characteristics from .dts file, better initialization, alarms
> > > >> and error reporting support, gear mode, polarity, fan pulse per
> > > >> revolution, fan startup voltage control.
> > > >
> > > > I wonder if this could be split into two separate drivers, one for
> > > > the pwm subsystem, and one for a hardware-independent fan controller
> > > > based on the pwm interfaces.
> > > 
> > > To be honest, I wouldn't even know how to start in order to do that.
> > > Additionally, it would be worth the effort if other drivers could be
> > > easily refactored using this idea. I'll let hwmon people provide some
> > > feedback and try and comply with their directions (based on the cpu
> > > cycle I can spend on this).
> > 
> > What Arnd proposes doesn't sounds like a very good idea. PWM-controlled
> > fans should be able to work just fine using a generic driver that uses
> > the PWM framework, similar to the PWM backlight and LED drivers.
> > 
> Isn't that exactly what Arnd proposed ?

Oh, right. I meant to say: "What Arnd proposes sounds like a very good
idea." =) Sorry for the confusion.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130528/da4412f3/attachment.sig>

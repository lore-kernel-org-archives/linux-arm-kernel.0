From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 29 Apr 2016 14:23:04 +0300
Subject: v4l subdevs without big device was Re:
 drivers/media/i2c/adp1653.c: does not show as /dev/video* or v4l-subdev*
In-Reply-To: <20160429110546.GU12528@pali>
References: <20160428084546.GA9957@amd> <20160429071525.GA4823@amd>
 <57230DE7.3020701@xs4all.nl>
 <20160429075649.GG32125@valkosipuli.retiisi.org.uk>
 <20160429095002.GA22743@amd>
 <20160429105944.GH32125@valkosipuli.retiisi.org.uk>
 <20160429110546.GU12528@pali>
Message-ID: <20160429112304.GJ32125@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 01:05:46PM +0200, Pali Roh?r wrote:
> On Friday 29 April 2016 13:59:44 Sakari Ailus wrote:
> > > pavel at amd:/data/l/linux-n900$ git fetch
> > > git://git.retiisi.org.uk/~sailus/linux.git leds-as3645a:leds-as3645a
> > > fatal: unable to connect to git.retiisi.org.uk:
> > > git.retiisi.org.uk: Name or service not known
> > > 
> > > pavel at amd:/data/l/linux-n900$ git fetch
> > > git://salottisipuli.retiisi.org.uk/~sailus/linux.git
> > > leds-as3645a:leds-as3645a
> > > remote: Counting objects: 132, done.
> > > remote: Compressing objects: 100% (46/46), done.
> > > remote: Total 132 (delta 111), reused 107 (delta 86)
> > > Receiving objects: 100% (132/132), 22.80 KiB | 0 bytes/s, done.
> > > Resolving deltas: 100% (111/111), completed with 34 local objects.
> > > From git://salottisipuli.retiisi.org.uk/~sailus/linux
> > >  * [new branch]      leds-as3645a -> leds-as3645a
> > 
> > Yeah, that works, too. git alias has been added some three weeks ago so
> > there seem to be something strange going on with DNS.
> 
> Maybe update SOA record?

The host has been added before that. It looks like the slaves are performing
the zone transfer nicely but for some reason they don't seem to correctly
respond when the newly added name is queried.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk

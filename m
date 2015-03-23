From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 23 Mar 2015 16:58:30 +0100
Subject: [PATCHv2] thermal: add omap3 support
In-Reply-To: <20150323143149.GA18339@developer.hsd1.ca.comcast.net>
References: <20150103111146.GB7065@amd> <20150118202824.GB29014@amd>
 <20150323143149.GA18339@developer.hsd1.ca.comcast.net>
Message-ID: <20150323155830.GB13297@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-03-23 10:31:51, Eduardo Valentin wrote:
> On Sun, Jan 18, 2015 at 09:28:24PM +0100, Pavel Machek wrote:
> > 
> > Add support for omap3430 sensor. Tested on Nokia N900.
> > 
> > Fix help text to be closer to english.
> > 
> > Ifdefs in ti-bandgap.h are not neccessary, as users have #ifdefs,
> > already.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> You need to update the driver device tree binding documentation. Please
> include an example of its usage there.
> 
> Also, a separate patch with the required DT changes is always
> welcome.

I can do it, but can you merge:

Date: Sun, 18 Jan 2015 21:24:47 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] ti-soc-thermal: request temperature periodically if
hw can't do that itself


Date: Sun, 18 Jan 2015 21:20:51 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] ti-soc-thermal: implement eocz bit to make driver
useful on omap3

Date: Sun, 18 Jan 2015 21:17:10 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCHv2] cleanup ti-soc-thermal

First? They are nicely split, as you requested, and I already have too
many patches in flight.

Thanks for the comments, I'll fix them in my local tree.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

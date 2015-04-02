From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 2 Apr 2015 16:44:10 +0200
Subject: [PATCHv7 0/2] INPUT: Route keyboard LEDs through the generic
 LEDs layer
In-Reply-To: <20150401211140.GI2901@type.youpi.perso.aquilenet.fr>
References: <20150217191527.GA9594@type.youpi.perso.aquilenet.fr>
 <201504012200.07408@pali>
 <20150401211140.GI2901@type.youpi.perso.aquilenet.fr>
Message-ID: <20150402144410.GB18125@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2015-04-01 23:11:40, Samuel Thibault wrote:
> Pali Roh?r, le Wed 01 Apr 2015 22:00:07 +0200, a ?crit :
> > On Tuesday 17 February 2015 20:15:27 Samuel Thibault wrote:
> > > Here is an updated version to fix the initialization of the
> > > vt_led_work queues before registering LEDs, and refresh
> > > against 3.19.
> > 
> > Hello! I would like to ask when will be this patch series merged 
> > into mainline kernel? Are there still some problems with it?
> 
> There are no known problems ATM.

I thought it made it to -next, but apparently not.

Dmitry, can you comment what needs to be done, or just merge it,
please?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

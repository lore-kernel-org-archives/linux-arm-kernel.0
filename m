From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 9 Sep 2010 10:27:17 +0200
Subject: [PATCH v2] Input: Make ADS7846 independent on regulator
In-Reply-To: <20100907125335.GD25830@sirena.org.uk>
References: <1280560182-7071-1-git-send-email-marek.vasut@gmail.com>
	<4C862EB3.4080006@compulab.co.il>
	<20100907125335.GD25830@sirena.org.uk>
Message-ID: <201009091027.18176.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 7. z??? 2010 14:53:35 Mark Brown napsal(a):
> On Tue, Sep 07, 2010 at 03:23:15PM +0300, Igor Grinberg wrote:
> >  Seems that there are some more platforms then Sharp Zaurus
> > 
> > are interested in this patch.
> > 
> > Dmitry, Mike, Pavel,
> > 
> > What's the status of it?
> 
> From a regulator API usage point of view a separate implementation of
> the same thing was nacked - there are regulator API facilties for hiding
> missing regulators from drivers when needed to get systems going, unless
> the device genuinely can cope without supplies it should be relying on
> those.

Maybe these platforms should have been fixed prior to applying the patch adding 
regulator goo into ads7846 driver then. What's the way to go now then ?

Thanks, Cheers

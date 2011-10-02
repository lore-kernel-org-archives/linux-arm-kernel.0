From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 21:48:13 +0200
Subject: [PATCH 02/26] sound/pxa-zylonite: use a valid device for dev_err()
In-Reply-To: <20111002184417.GE2857@opensource.wolfsonmicro.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<2376094.AH5MH8IXqN@wuerfel>
	<20111002184417.GE2857@opensource.wolfsonmicro.com>
Message-ID: <11180812.GzalXgfRcs@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 19:44:17 Mark Brown wrote:
> On Sun, Oct 02, 2011 at 08:36:14PM +0200, Arnd Bergmann wrote:
> 
> > I also have a few sound/soc fixes in the respective samsung and
> > omap series, so if you prefer I can move them to a sound/soc
> > series and submit them all at once to you instead.
> 
> Please do.  It's probably not so important at this point in the release
> cycle but we've got a tendency to run into cross tree issues with ASoC
> and when it's not trivial build stuff I'd rather review anyway.
> 
> Please split the OMAP stuff out, Liam manages the tree for those when
> he's available (though right now he's only intermittently online so I'm
> applying those too).

Almost all the patches I have are both trivial and unimportant corner
cases. I'm removing the ones I have from all the other branches now
and will try to get them to you both asap.

> > The subject line was hand-written, any problem in there is purely
> > my own. What is the naming you want for sound/soc, should I use
> > "ASoC: pxa-zylonite:" or "sound/soc/pxa/zylonite:" or something
> > else?
> 
> ASoC: is the bit that I'm looking for.

Ok, got it.

	Arnd

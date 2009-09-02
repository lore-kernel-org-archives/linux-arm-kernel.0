From: broonie@sirena.org.uk (Mark Brown)
Date: Wed, 2 Sep 2009 15:51:37 +0100
Subject: AC97 on  i.MX27
In-Reply-To: <200909021607.03679.marek.vasut@gmail.com>
References: <OF744AA145.8166D38C-ONC1257625.0041CD11-C1257625.0041F924@phytec.de>
	<200909021607.03679.marek.vasut@gmail.com>
Message-ID: <20090902145137.GE4012@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2009 at 04:07:03PM +0200, Marek Vasut wrote:
> Dne St 2. z?????? 2009 13:59:50 Jan Weitzel napsal(a):

> > I am trying to get an Wolfson WM9712L working with AC97 on a i.MX27. I saw
> > some patches for 2.6.22 on the list. Does anybody have further worked on
> > this, or is it a good point to start from?

> WM9712 is supported by mainline kernel since long ago.

Indeed; if nothing else it's standard conforming for the audio so a
vanilla AC97 driver should just work.  The problem is more the i.MX AC97
controller - there's some more current support for it in

	git://opensource.wolfsonmicro.com/linux-2.6-asoc.git dev

however I've no idea if it actually works or not.

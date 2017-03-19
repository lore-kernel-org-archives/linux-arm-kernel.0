From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 19 Mar 2017 00:37:47 -0700
Subject: outreachy/moving a driver out of staging
In-Reply-To: <20170309212021.GA24433@kroah.com>
References: <alpine.DEB.2.20.1703092133340.2306@hadrien>
 <443f0143-aec1-2559-a2c2-73b245632948@broadcom.com>
 <2da12619-5fcb-9e0f-b6c1-c83cbf491e8d@wwwdotorg.org>
 <20170309212021.GA24433@kroah.com>
Message-ID: <1489909067.1536.14.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-03-09 at 22:20 +0100, Greg KH wrote:
> On Thu, Mar 09, 2017 at 01:56:49PM -0700, Stephen Warren wrote:
> > On 03/09/2017 01:51 PM, Scott Branden wrote:
> > > Hi Julia,
> > > 
> > > On 17-03-09 12:36 PM, Julia Lawall wrote:
> > > > Hello,
> > > > 
> > > > I discussed the issue of outreachy patches for bcm with Greg,
> > > > and we are
> > > > not convinced that not having the patches CCd to you is such a
> > > > good idea.
> > > > While we don't want to spam you with noise, some of the
> > > > applicants are
> > > > starting to make more significant changes that it could be
> > > > useful for you
> > > > to be aware of.
> > > > 
> > > > Could we try a compromise where you are not CCd on whitespace
> > > > patches,
> > > > but
> > > > you are CCd on patches that actually modify the code?
> > > 
> > > All I'm asking is you work through your outreachy patches
> > > internal first
> > > to get rid of the most basic mistakes and email traffic it is
> > > geerating.
> > > ?Once that learning process is through then they can be sent out
> > > like
> > > any other patches to the kernel mailing lists and maintainers.
> > 
> > +1 from me too; I find these patches rather high volume and had to
> > add a
> > filter to keep them out of my primary inbox.
> 
> Hah!??That's the joy of being a maintainer of a driver in
> staging.??Even
> if you filter out outreachy, you are going to get a lot of "basic
> mistakes" and other type patches cc:ed to you.
> 
> I strongly suggest, that if you all don't like this type of stuff,
> either:
> 	- work to get the code out of staging as soon as possible (i.e.
> 	??send me coding style fixes for everything right now, and then
> 	??fix up the rest of the stuff.)
> 	- take yourself off the maintainer list for this code.
> 
> It's your choice, outreachy right now is a lot of patches, but again,
> it's not going to keep you from getting the "basic" stuff sent to you
> in ways that is totally wrong.
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

I just noticed this e-mail.  What exactly is the requirement to get a
driver or subsystem out of staging?

I can image a day when vc04_services or VideoCore gets moved out of
staging at some point. What exactly would it take to make something
like that happen?

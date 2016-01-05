From: lftan@altera.com (Ley Foon Tan)
Date: Tue, 5 Jan 2016 08:45:45 +0800
Subject: [PATCH] doc: PCI: altera: Fix the 'ranges' property in example
In-Reply-To: <201601040212.23854.marex@denx.de>
References: <1450950330-28393-1-git-send-email-marex@denx.de>
 <201601040137.57271.marex@denx.de> <1451868802.3051.20.camel@ubuntu>
 <201601040212.23854.marex@denx.de>
Message-ID: <1451954745.3051.24.camel@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-04 at 02:12 +0100, Marek Vasut wrote:
> On Monday, January 04, 2016 at 01:53:22 AM, Ley Foon Tan wrote:
> > On Mon, 2016-01-04 at 01:37 +0100, Marek Vasut wrote:
> > > On Monday, January 04, 2016 at 01:10:13 AM, Ley Foon Tan wrote:
> > > 
> > > Hi!
> > > 
> > > > > > > Well, do you have a good explanation why the system works with
> > > > > > > this change and doesn't work without it on my design ? I'd
> > > > > > > really love to understand this.
> > > > > > 
> > > > > > Do you modify the driver to setup the translation table?
> > > > > 
> > > > > No, I didn't change the driver. What do you refer to please ?
> > > > 
> > > > There is Address Translation Table at address offset 0x1000 in the IP.
> > > 
> > > Oh, I didn't configure that in any way. Should I or does the driver
> > > configure it in some way?
> > > 
> > > > Do you use the hardware design from the rocketboards.org or your own
> > > > design?
> > > 
> > > I use the one from rocketboards, I just ported it over to the MCVEVK
> > > (custom cyclone v soc board)
> > 
> > You may check again the base addresses use in the MCVEVK board.
> 
> The address map is attached ; I don't see anything which would differ from the 
> reference design.
Address map looks fine.
> 
> btw I am honestly surprised that Quartus cannot export the address map into some 
> text file :-(
There is a *.html file in the generated directory.

Regards
Ley Foon

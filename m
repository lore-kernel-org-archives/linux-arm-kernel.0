From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 Nov 2009 09:08:45 +0100
Subject: Status of Dream series
In-Reply-To: <1258540955.8014.4.camel@ubuntu>
References: <20091111104748.GA26975@elf.ucw.cz>
	<1258135899.6411.7.camel@c-dwalke-linux.qualcomm.com>
	<20091118170238.GE20887@elf.ucw.cz>
	<1258537122.8014.2.camel@ubuntu>
	<20091118181824.GK25150@elf.ucw.cz>
	<1258540955.8014.4.camel@ubuntu>
Message-ID: <20091119080845.GB30454@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-11-18 10:42:35, Daniel Walker wrote:
> On Wed, 2009-11-18 at 19:18 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > > > Russell, what is the status of the "Dream" series? 
> > > > > > 
> > > > > >  [PATCH 1/3] msm: make debugging UART (for DEBUG_LL) configurable
> > > > > >  [PATCH 2/3] msm: add minimal board file for HTC Dream device
> > > > > >  [PATCH 3/3] msm: Add memory map for HTC Dream
> > > > > > 
> > > > > > Daniel Walker offered to maintain arch-msm tree, would that help? 
> > > > > 
> > > > > Yeah, I can do it for now, but I can't accept patches for it via this
> > > > > email address.. I'm in the processes of setting up the right address for
> > > > > it .. Might take till next week tho.
> > > > 
> > > > Ok, can I just add your acked-by, and send them to akpm/rmk? These
> > > > three are simple enough...
> > > 
> > > Didn't Russell have some pending comments? Anyway, I have them already
> > > in my korg git tree. So I can move them forward from there , but it's
> > > temporary ..
> > 
> > Here's fixed #2. I guess we can add rmk's reviewed-by (and yours?) and
> > send them forward?
> 
> I'll add my sign off, put them into my git tree (which is included in
> linux-next) , the eventually push them to Linus when the merge window
> opens ..

Thanks! You should probably add yourself into the MAINTAINER file, too...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

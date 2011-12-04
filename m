From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 4 Dec 2011 20:53:14 +0100
Subject: [PATCH 2/3] ARM: mach-shmobile: Use common always on power domain
 governor
In-Reply-To: <20111204012239.GA31215@opensource.wolfsonmicro.com>
References: <1322765339-29879-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <201112032331.07336.rjw@sisk.pl>
 <20111204012239.GA31215@opensource.wolfsonmicro.com>
Message-ID: <201112042053.14351.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, December 04, 2011, Mark Brown wrote:
> On Sat, Dec 03, 2011 at 11:31:07PM +0100, Rafael J. Wysocki wrote:
> > On Saturday, December 03, 2011, Mark Brown wrote:
> 
> > > The first patch in the series added the replacement as generic code,
> > > this patch is deleting the shmobile specific implementation and using
> > > the generic code instead.
> 
> > No, the first patch didn't add any replacements for the functions that the
> > second patch removed.  At least I don't see the replacements in the first
> > patch.
> 
> Oh, right.  It'd really help if you were more specific.  I'd probably
> have realised earlier that you are probably talking about the stop_dev
> and start_dev functions which appear to have got caught up in the mess
> of a rebase somehow - I didn't intentionally remove them as their
> absence from the patch description and the lack of any removal of
> references to them should suggest.

Well, I mentioned these two functions specifically in my first reply to the
patch message. :-)

Thanks,
Rafael

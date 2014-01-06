From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 6 Jan 2014 14:34:36 -0800
Subject: Possible arm64 patches for stable
In-Reply-To: <20131231060453.GA22732@kroah.com>
References: <20131220172827.GZ31886@sirena.org.uk>
 <20131231060453.GA22732@kroah.com>
Message-ID: <20140106223436.GA9235@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 10:04:53PM -0800, Greg Kroah-Hartman wrote:
> On Fri, Dec 20, 2013 at 05:28:27PM +0000, Mark Brown wrote:
> > Hi,
> > 
> > While reading the kernel logs for arm64 (as one does) I noticed a few
> > patches that seemed like candidates for either LTS or LTSI.  I've also
> > had a couple of others mentioned via other routes.  What do you think of
> > these?
> > 
> >   4ecf7ccb1973 arm64: spinlock: retry trylock operation if strex fails on free lock
> > 
> > This seems like a correctness fix for spinlocks, though since the
> > callers should cope with failure it's arguably just an optimisation.
> 
> I've applied this one to 3.10-stable and will look over the others when
> I catch up on my larger patch queue, thanks.

All of the other ones looked good to me and I've queued them up now,
thanks.

greg k-h

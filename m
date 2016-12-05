From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 5 Dec 2016 13:44:53 +0100
Subject: [stable:PATCH 0/3] PAN fixes backport for v4.4.35
In-Reply-To: <584538CC.50807@arm.com>
References: <20161202164247.19496-1-james.morse@arm.com>
 <20161202172321.GA25426@kroah.com> <584538CC.50807@arm.com>
Message-ID: <20161205124453.GA18874@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 09:52:12AM +0000, James Morse wrote:
> Hi Greg,
> 
> On 02/12/16 17:23, Greg KH wrote:
> > On Fri, Dec 02, 2016 at 04:42:44PM +0000, James Morse wrote:
> >> Hi linux-stable,
> >>
> >> This is the backport of the recent PAN fixes series for v4.4.35.
> >> Original series:
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/461806.html
> > 
> > Why just 4.4-stable?  What about 4.8-stable?
> 
> Patch 1 doesn't backport easily. I was going to do v4.8 next, but thought one at
> a time would be the least confusing...
> 
> (I don't seem to be very good at predicting what is confusing!)

Adding a patch to an "old" stable kernel would be odd if the latest
stable kernel also doesn't have it, right?  I need for it to be in 4.8
before I can take it into 4.4, sorry.

So I'll hold off on applying these until that happens.

thanks,

greg k-h

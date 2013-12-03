From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 3 Dec 2013 13:03:33 -0500
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <20131203170310.7099a706@alan.etchedpixels.co.uk>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
 <20131203160018.67542a53@alan.etchedpixels.co.uk>
 <529E04AB.5060304@linaro.org>
 <20131203163228.3313dff8@alan.etchedpixels.co.uk>
 <1386088897.13256.66.camel@kazak.uk.xensource.com>
 <20131203170310.7099a706@alan.etchedpixels.co.uk>
Message-ID: <20131203180333.GH3734@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 05:03:10PM +0000, One Thousand Gnomes wrote:
> > itself. The protocol is defined by an entity which is external to Linux.
> > If this had been a bug in the IP protocol handling we would fix it and
> > move on. This case is no different IMHO.
> 
> Actually that is quite untrue. We are *very* careful that we can talk to
> other internet nodes that speak broken versions of TCP. There have even
> been changes made to protocol definitions during initial research to
> avoid tripping bugs in existing implementations.
> 
> > Once we set the ABI in stone then this is the sort of thing we will care
> > very much about (as we have done for many years on x86). Until then it
> > is not.
> 
> Maybe Xen doesn't, but perhaps Linux doesn't wish to be tarred with the
> same brush. What Xen decides is the official protocol is Xen's decision.
> What a Linux guest does to keep compatibility ought to follow what Linux
> does as policy.

I believe that this patch does not alter the x86 protocols.
Only the ARM based ones which are still in Technical Preview.

> 
> Alan

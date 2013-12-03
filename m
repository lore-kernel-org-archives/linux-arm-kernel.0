From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 3 Dec 2013 17:03:10 +0000
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <1386088897.13256.66.camel@kazak.uk.xensource.com>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
 <20131203160018.67542a53@alan.etchedpixels.co.uk>
 <529E04AB.5060304@linaro.org>
 <20131203163228.3313dff8@alan.etchedpixels.co.uk>
 <1386088897.13256.66.camel@kazak.uk.xensource.com>
Message-ID: <20131203170310.7099a706@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> itself. The protocol is defined by an entity which is external to Linux.
> If this had been a bug in the IP protocol handling we would fix it and
> move on. This case is no different IMHO.

Actually that is quite untrue. We are *very* careful that we can talk to
other internet nodes that speak broken versions of TCP. There have even
been changes made to protocol definitions during initial research to
avoid tripping bugs in existing implementations.

> Once we set the ABI in stone then this is the sort of thing we will care
> very much about (as we have done for many years on x86). Until then it
> is not.

Maybe Xen doesn't, but perhaps Linux doesn't wish to be tarred with the
same brush. What Xen decides is the official protocol is Xen's decision.
What a Linux guest does to keep compatibility ought to follow what Linux
does as policy.

Alan

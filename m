From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 19 Apr 2013 17:02:09 -0300
Subject: [PATCH v7 1/5] drivers: memory: Introduce Marvell EBU Device Bus
 driver
In-Reply-To: <20130419181633.GA31753@kroah.com>
References: <1365620644-15790-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365620644-15790-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130410191641.GG28693@titan.lakedaemon.net>
 <20130410194337.GA5681@kroah.com> <20130419181058.GA2243@localhost>
 <20130419181633.GA31753@kroah.com>
Message-ID: <20130419200208.GA12621@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg, 

On Fri, Apr 19, 2013 at 11:16:33AM -0700, Greg KH wrote:
> > On Wed, Apr 10, 2013 at 12:43:37PM -0700, Greg KH wrote:
> > > > On Wed, Apr 10, 2013 at 04:04:00PM -0300, Ezequiel Garcia wrote:
[...]
> > 
> > Is it possible that you take this patch instead, so it can make it in v3.10?
> 
> Sure, resend it to me today please.
> 

Forget about it. This Device Bus driver depends on the recent Mbus
driver, which was supposed to get pulled in the same branch.

I don't see an easy way to merge both of these, considering we're
so close to the merge window.

Thanks anyway and sorry for the noise.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

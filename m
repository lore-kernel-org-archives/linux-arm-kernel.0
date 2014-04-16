From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 16 Apr 2014 12:49:27 -0300
Subject: [PATCH 4/6] thermal: armada: Support Armada 375 SoC
In-Reply-To: <20140416153819.GF28159@titan.lakedaemon.net>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140416153819.GF28159@titan.lakedaemon.net>
Message-ID: <20140416154927.GA1892@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Thanks for taking a look.

On Apr 16, Jason Cooper wrote:
> On Wed, Apr 16, 2014 at 11:15:18AM -0300, Ezequiel Garcia wrote:
> > +	/* This is only needed on A375 Z1 SoC silicon revision */
> > +	reg |= A375_Z1_WORKAROUND_BIT;
> 
> and this seem to be the only differences between the two init functions.
> 
> It also appears to be the only reason for having two data structs below.
> Is it worth checking for the compatible string in the init function so
> you only have one init and one data struct?
> 

Yes, thought about it at one point but I guess it seemed to me cleaner
this way.

I'll squash it if you think keeping two structs is stupid bloat.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

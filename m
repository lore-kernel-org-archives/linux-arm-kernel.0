From: osandov@osandov.com (Omar Sandoval)
Date: Thu, 31 Jul 2014 20:07:46 -0700
Subject: [PATCH] ARM/ARM64: don't enter kgdb when userspace executes a
 kgdb break instruction.
In-Reply-To: <20140731104653.GM26853@arm.com>
References: <20140730071245.GA8954@mew.web-pass.com>
 <20140730112414.GJ12239@arm.com>
 <20140731053323.GA15523@mew.web-pass.com>
 <20140731104653.GM26853@arm.com>
Message-ID: <20140801030746.GA26941@mew>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Will,

On Thu, Jul 31, 2014 at 11:46:53AM +0100, Will Deacon wrote:
> I'll merge the arm64 diff I proposed. Could you repost the ARM part please?
I've just reposted it, hopefully we can get that merged in soon as well.

> I think enabling and activating kgdb by default is a pretty crazy thing to
> do, but I agree that we shouldn't allow userspace to trap into it either.
Agreed, hopefully the actual footprint of this bug isn't too large, but it's
worth fixing anyways.

> Once you repost the ARM patches, we can look at getting them merged via rmk.
> 
> Cheers,
> 
> Will

Thanks again!
Omar

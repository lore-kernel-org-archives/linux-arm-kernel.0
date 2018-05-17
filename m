From: vincent.weaver@maine.edu (Vince Weaver)
Date: Thu, 17 May 2018 12:02:08 -0400 (EDT)
Subject: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <87efia1hjg.fsf@anholt.net>
References: <20180517131727.29263-1-eric@anholt.net>
 <alpine.DEB.2.21.1805171007260.7820@macbook-air> <87efia1hjg.fsf@anholt.net>
Message-ID: <alpine.DEB.2.21.1805171159110.7984@macbook-air>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018, Eric Anholt wrote:
> 
> Is that better than a53?  I'm happy to switch to that.  The important
> part to me is the a7, since basically everyone with this hw is running
> arm32.

no, on further investigation it looks like a53 is more proper to use than 
the generic armv8.

Is the armv8 pmu on the cortex-a53 backwards compatible with armv7?  I'm 
dreading having to pull up the various ARM ARMs to look for myself so if 
it works for you I'm fine with that part too.

The biggest pushback I had with my original patch was no one believing irq 
9 was the right one to use.

Vince

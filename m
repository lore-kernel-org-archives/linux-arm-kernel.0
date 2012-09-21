From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Sep 2012 20:29:46 -0700
Subject: [GIT PULL] omap header cleanup to make headers local for v3.7
 merge window
In-Reply-To: <20120920230935.GM28835@atomide.com>
References: <20120920230935.GM28835@atomide.com>
Message-ID: <20120921032946.GA22479@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 04:09:36PM -0700, Tony Lindgren wrote:
> Hi Arnd & Olof,
> 
> Here's one more branch to take us a bit closer to getting the
> single zImage working on omaps. It would be nice to get merged
> into arm-soc/next/cleanup before the merge window if still
> possible.
> 
> I've based it on top of Arnd's 2203747c (ARM: omap: move
> platform_data definitions) to avoid more merge conflicts,
> and it seems to merge with few trivial include conflicts
> with current linux next and arm-soc/for-next.

Done, pulled in as omap/cleanup-headers and into next/cleanup.


-Olof

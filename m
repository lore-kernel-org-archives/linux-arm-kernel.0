From: will.deacon@arm.com (Will Deacon)
Date: Tue, 23 Sep 2014 11:47:16 +0100
Subject: [PATCH] arm64, defconfig: Increase NR_CPUS default to 64
In-Reply-To: <20140923104431.GF20170@rric.localhost>
References: <1410176689-20020-1-git-send-email-rric@kernel.org>
 <20140923104431.GF20170@rric.localhost>
Message-ID: <20140923104716.GG26472@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 11:44:31AM +0100, Robert Richter wrote:
> On 08.09.14 13:44:48, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > Raising the current maximum limit to 64. This is needed for Cavium's
> > Thunder systems that will have at least 48 cores per die.
> > 
> > The change keeps the current memory footprint in cpu mask structures.
> > It does not break existing code. Setting the maximum to 64 cpus still
> > boots systems with less cpus.
> > 
> > Mark's Juno happily booted with a NR_CPUS=64 kernel.
> > 
> > Tested on our Thunder system with 48 cores. We could see interrupts to
> > all cores.
> 
> Catalin, Will,
> 
> please consider applying this patch.

I thought this was queued already?

Will

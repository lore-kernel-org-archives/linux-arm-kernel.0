From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Mar 2010 14:45:32 +0000
Subject: Highmem issues with MMC filesystem
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4947FE3@dbde02.ent.ti.com>
References: <c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
	<20100318141930.GF19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003181205020.31128@xanadu.home>
	<20100319015523.GD14108@shareable.org>
	<alpine.LFD.2.00.1003190908330.31128@xanadu.home>
	<5080.10.24.255.18.1269008921.squirrel@dbdmail.itg.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4947FE3@dbde02.ent.ti.com>
Message-ID: <20100319144532.GF21280@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 08:06:12PM +0530, Shilimkar, Santosh wrote:
> Since the cache_flush is helping and we are talking about DMA_FROM_DEVICE
> case, Russells recent DMA mapping series does have fix for this.
> 
> Do you have Russell's DMA mapping series integrated in your kernel you are
> trying ? It's already in the 2.6.34-rc1

I wonder whether we can get _one_ email from each person who has
encountered the problem giving full details of what kernels they're
running and the problem is that they've experienced.

At the moment, that information is spread throughout this thread,
with some clues from one person and others from another person -
there's no way to tie this all together, and I certainly can't follow
it.

So, let's end this thread here (I'm going to start ignoring it), and
start a new one with some *proper* and *full* bug reports from *each*
person with a problem.

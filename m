From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 17:06:19 +0000
Subject: IXP4xx current status
In-Reply-To: <m3lj2mi047.fsf@intrepid.localdomain>
References: <m3lj2mi047.fsf@intrepid.localdomain>
Message-ID: <20110115170619.GK15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 05:48:40PM +0100, Krzysztof Halasa wrote:
> Hi,
> 
> I just compiled and booted current Linus' git tree on my Goramo
> MultiLink (IXP425-based) and it seems to work.
> 
> I have two IXP4xx patches to be sent to Linus at this point, including:
> - Rename FREQ macro to avoid collisions by Ben Hutchings
> - Fix qmgr_release_queue() flushing unexpected queue entries (mine).
> 
> If I'm supposed to add anything to this list, please let me know.

It would be nice to have the patches posted here, so they end up in the
list archives (and so are searchable for "why was that done?" type
questions.)

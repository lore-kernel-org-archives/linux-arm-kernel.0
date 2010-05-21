From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 20:10:25 +0100
Subject: [PATCH] ARM: S5PV210: Add GONI board support
In-Reply-To: <AANLkTikKmNSqLwvpvj3DQVEoKgE6gvt0eBLxiwRswx09@mail.gmail.com>
References: <4BF3F284.5090505@samsung.com>
	<20100520004856.GK4720@trinity.fluff.org>
	<AANLkTikKmNSqLwvpvj3DQVEoKgE6gvt0eBLxiwRswx09@mail.gmail.com>
Message-ID: <20100521191025.GC11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 10:10:33AM +0900, Kyungmin Park wrote:
> In the previous time, Marek sent the s5pv210 patch including the
> aquila board support.
> But in this merge cycle, it doesn't included. of course all s5pv210 patches too,
> Please find the patch subject "ARM: S5PV210: add Aquila board" and
> check it again.

The merge windows are not for people to send their patches which they've
been sitting on to mailing lists.  The merge window is for the patches
prepared and reviewed _prior_ to the merge window opening, and which
have been tested in the linux-next tree to be merged into Linus' tree.

I make this comment because it seems to me that as soon as the merge
window opened, this mailing list immediately got flooded with Samsung
patches.  This is not the way it works.

In future, please prepare your patches before the merge window, and
submit them to the mailing list for review as soon as they're prepared.
Once they've been reviewed, they can be queued and sit in linux-next
for a while for the following merge window.

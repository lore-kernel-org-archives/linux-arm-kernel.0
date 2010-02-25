From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 21:29:15 +0000
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100225205113.GF3101@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
Message-ID: <20100225212915.GA24043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 08:51:13PM +0000, Russell King - ARM Linux wrote:
> Err, you've rebased your tree since I last pulled it, and this now results
> in the following, and a load of duplicated commits between the two trees.
> 
> This is not nice, please don't rebase stuff which I've already pulled.
> 
> I'm going to think about what to do about this; I can't trivially drop
> your previous work from my tree.

What happened to this commit?

[ARM] pxa/ttc_dkb: remove duplicate macro definition

which follows:

[ARM] pxa/raumfeld: add defconfig
[ARM] pxa/raumfeld: add platform support

in your previous pull request?  I can find these two in your latest with
different commit IDs, but not the pxa/ttc_dkb patch.

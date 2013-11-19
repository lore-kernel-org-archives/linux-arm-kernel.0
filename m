From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 19 Nov 2013 14:54:40 -0500
Subject: [RFC PATCH V2 2/2] kbuild: dtbs_install: new make target
In-Reply-To: <20131119192246.GP16735@n2100.arm.linux.org.uk>
References: <20131118192852.GI10335@titan.lakedaemon.net>
 <528A6CA3.9030904@wwwdotorg.org>
 <20131118195243.GJ10335@titan.lakedaemon.net>
 <528A98C8.9040803@wwwdotorg.org>
 <20131119122801.GL16735@n2100.arm.linux.org.uk>
 <20131119142336.GA28859@titan.lakedaemon.net>
 <20131119150212.GM16735@n2100.arm.linux.org.uk>
 <20131119152047.GB28859@titan.lakedaemon.net>
 <20131119152146.GN16735@n2100.arm.linux.org.uk>
 <20131119192246.GP16735@n2100.arm.linux.org.uk>
Message-ID: <20131119195439.GE28859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 07:22:46PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 19, 2013 at 03:21:46PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Nov 19, 2013 at 10:20:47AM -0500, Jason Cooper wrote:
> > > By "That" are you referring to extending the standard for compatible
> > > strings to the board level, or forcing consistent naming on the dts
> > > files?
> > 
> > A consistent file naming on both the dtb and dts files.
> 
> It's time to knock the idea of naming the DT blobs after the compatible
> string on its head as well.  That's really not going to work.  Just
> leave the filenames as is, and move the problem into userspace to solve.

Ack, I was working my way towards that anyway.

> See - by doing this, you are building policy into the kernel build
> system and potentially taking away choice from userspace.

And this is my reason for dropping the idea.  Thanks for clarifying it
for me.  I'll submit a non-RFC version that just copies the files
without the name change.

thx,

Jason.

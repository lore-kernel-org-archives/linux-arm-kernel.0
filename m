From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 30 Mar 2010 15:59:53 -0700
Subject: [GIT PULL] generic arm for MSM try2
In-Reply-To: <20100328214901.GA8614@n2100.arm.linux.org.uk>
References: <1269560155.21793.89.camel@c-dwalke-linux.qualcomm.com>
	<20100328214901.GA8614@n2100.arm.linux.org.uk>
Message-ID: <1269989993.23416.18.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-03-28 at 22:49 +0100, Russell King - ARM Linux wrote:
> On Thu, Mar 25, 2010 at 04:35:55PM -0700, Daniel Walker wrote:
> > Ok, attempt #2 .. It's the same set of patches , only it's against
> > mainline linus tree of the moment. I force updated it into the same
> > "for-russell" branch.
> > 
> > btw, you might want to pay close attention to the "Fix incorrect
> > permission faults" patch. That's the only non-small patch in the queue.
> 
> Well, I don't think it's fair on those who created abort-ev7.S to go
> throwing a boilerplate copyright on the file which makes it look like
> "Code Aurora Forum." wrote the entire thing.

Ok, I updated the same branch .. It's minus the copyright and license ,
and I rebased it onto a more recent linus tree ..

Daniel

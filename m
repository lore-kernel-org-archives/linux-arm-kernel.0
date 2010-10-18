From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 22:11:19 +0100
Subject: Last call for new machine support
Message-ID: <20101018211119.GB20376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tuesday evening my time (BST, so UTC+1h) is the last time I'm merging
anything into my git tree.

With the upcoming change to the debug macro infrastructure, there are
two options for people who have new board support code external to my
tree:

1. Send me a pull request (based on Linus' tree not mine) by Tuesday.

2. Eat merge conflicts and build breakage for breakfast when my tree
   merges into mainline.  ;)

No further complaints about this please - there's been plenty of warning
about these debug macro changes.

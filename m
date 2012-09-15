From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 14 Sep 2012 20:13:25 -0400
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <20120910082941.GO13739@n2100.arm.linux.org.uk>
References: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
 <20120909204705.GD3451@lunn.ch>
 <20120909205521.GI13739@n2100.arm.linux.org.uk>
 <20120909210126.GM4575@titan.lakedaemon.net>
 <20120910004511.GN13739@n2100.arm.linux.org.uk>
 <20120910014422.GQ4575@titan.lakedaemon.net>
 <20120910082941.GO13739@n2100.arm.linux.org.uk>
Message-ID: <20120915001325.GD5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 09:29:42AM +0100, Russell King - ARM Linux wrote:
> On Sun, Sep 09, 2012 at 09:44:22PM -0400, Jason Cooper wrote:
> > iiuc, the regression you are refering to would occur iff this patch
> > (without the select) makes it into mainline _before_ Andrew's patch in
> > Greg's tree.  As I haven't pulled this patch yet, I can add a dependency
> > in the tag message listing the patch in gregkh's usb tree.
> 
> For the regression to occur, you need to land on a commit in the tree
> where this patch (without the select) is in the history but not the
> patch in Greg's tree.
> 
> The commit history remains a series of independent branches even after
> trees are merged into Linus' tree - there is _no_ linearisation of the
> history in git.

<ding> (light comes on).  Thank you!  Somewhere in the time I've been
working with git I developed an incorrect assumption.  While
embarrassing, I'm glad I asked for clarification.

Anytime I view the merging of branches in my head, I always see gitg's
"all branches" view.  Since patches are sorted over time, I assumed they
became related that way once they were merged.  It sounds silly as I
type it out loud. :-)

It all makes sense now.

Thanks for taking the time to explain it so clearly,

Jason.

From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 7 Aug 2018 12:18:41 +0100
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <20180806130500.GB5985@e113682-lin.lund.arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <20180806130500.GB5985@e113682-lin.lund.arm.com>
Message-ID: <20180807111841.GF9097@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2018 at 03:05:00PM +0200, Christoffer Dall wrote:
> On Thu, Jun 21, 2018 at 03:57:24PM +0100, Dave Martin wrote:
> > This series implements basic support for allowing KVM guests to use the
> > Arm Scalable Vector Extension (SVE).
> > 
> > The patches is based on torvalds/master f5b7769e (Revert "debugfs:
> > inode: debugfs_create_dir uses mode permission from parent") plus the
> > patches from [1].
> 
> Given the effort required to go fetch another patch set from the list to
> apply to a specific commit, and the size of this patch set, it would be
> helpful to have a pointer to a branch with everything in it.

Fair enough.  This probably won't be an issue for the next spin, in
any case, but I can push a branch somewhere otherwise.

Cheers
---Dave

From: christoffer.dall@arm.com (Christoffer Dall)
Date: Mon, 6 Aug 2018 15:05:00 +0200
Subject: [RFC PATCH 00/16] KVM: arm64: Initial support for SVE guests
In-Reply-To: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180806130500.GB5985@e113682-lin.lund.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 03:57:24PM +0100, Dave Martin wrote:
> This series implements basic support for allowing KVM guests to use the
> Arm Scalable Vector Extension (SVE).
> 
> The patches is based on torvalds/master f5b7769e (Revert "debugfs:
> inode: debugfs_create_dir uses mode permission from parent") plus the
> patches from [1].

Given the effort required to go fetch another patch set from the list to
apply to a specific commit, and the size of this patch set, it would be
helpful to have a pointer to a branch with everything in it.

Thanks,
-Christoffer

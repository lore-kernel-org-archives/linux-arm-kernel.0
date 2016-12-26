From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Mon, 26 Dec 2016 18:49:51 +0000
Subject: v4.10-rc1 - build failure arm64?
In-Reply-To: <e47e230c-4e76-a7b7-a408-ada809a3b1b8@ti.com>
References: <9e720e28-469f-6a06-a97c-9d52ce951bfb@ti.com>
 <e47e230c-4e76-a7b7-a408-ada809a3b1b8@ti.com>
Message-ID: <20161226184951.GS1555@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2016 at 12:46:58PM -0600, Nishanth Menon wrote:

> A bit of bisect later, looks like reverting the following commit allows the
> build to proceed. -> note: there is no fail on multi_v7_defconfig or
> omap2plus_defconfig even without the revert.

See git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git#arm64-fix

From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 26 Nov 2013 11:06:59 -0700
Subject: [PATCH v3 2/2] PCI: mvebu - Support a bridge with no IO port
 window
In-Reply-To: <20131125181008.158b5b09@skate>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1383262380-6984-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131125181008.158b5b09@skate>
Message-ID: <20131126180659.GB19852@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 06:10:08PM +0100, Thomas Petazzoni wrote:

> Thanks, and sorry again for the huge time it took me to test this
> version of your patches.

Thanks Thomas, I've rebased to v3.13-rc1, re-tested here, and re-sent
the patches.

There are two more you should look at - one should head into v3.13 as
it fixes a small regression.

Bjorn, Jason C has asked these go through your tree from now on.

Thanks,
Jason

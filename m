From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 19:22:19 +0100
Subject: [PATCH 2/3] [ARM] pxa: remove useless NODE_MEM_SIZE_BITS
In-Reply-To: <1277130154-25912-2-git-send-email-eric.y.miao@gmail.com>
References: <1277130154-25912-1-git-send-email-eric.y.miao@gmail.com>
	<1277130154-25912-2-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20100621182219.GB13624@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 10:22:33PM +0800, Eric Miao wrote:
> As DISCONTIGMEM is not enabled on PXA, remove this useless bit.

You need to look at my LMB or devel branch.  This is gone already there.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Jul 2010 08:12:45 +0100
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on S5PV210/S5PC110.
In-Reply-To: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100706071245.GA5058@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 06, 2010 at 01:36:47PM +0900, Kukjin Kim wrote:
> This patch fixes on SECTION_SIZE_BITS for Sparsemem on S5PV210/S5PC110.
> Because smallest size of a bank on S5PV210/S5PC110 is aligned by 16MB.
> So each section's maximum size should be 16MB.

What is the spacing of chunks of memory, and minimum alignment of those
chunks in physical address space?

Also, what is the maximum physical address which memory can be located?

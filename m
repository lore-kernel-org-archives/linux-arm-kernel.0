From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Mar 2011 08:23:19 +0000
Subject: [PATCH 2/3] ARM: EXYNOS4: Suspend to RAM Support
In-Reply-To: <1299636521-4831-3-git-send-email-jc.lee@samsung.com>
References: <1299636521-4831-1-git-send-email-jc.lee@samsung.com>
	<1299636521-4831-3-git-send-email-jc.lee@samsung.com>
Message-ID: <20110309082319.GC605@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2011 at 11:08:40AM +0900, Jaecheol Lee wrote:
> This patch adds support suspend to ram for EXYNOS4210.
> As a note, this includes function of outer cache flush
> because it is used before entering PM.

This should be updated to use the generic CPU sleep support, found in my
tree.

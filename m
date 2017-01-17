From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2017 17:41:42 +0000
Subject: [PATCH 0/3] arm64: {adr,ldr}_l cleanup
In-Reply-To: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
References: <1484669458-31713-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170117174142.GP27328@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 04:10:55PM +0000, Mark Rutland wrote:
> While looking at the way we use adrp, I spotted that there are still a few
> open-coded instances of adr_l and ldr_l.
> 
> These patches clean those up, making the code a little easier to follow.

Thanks, queued for 4.11.

Will

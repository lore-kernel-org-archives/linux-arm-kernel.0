From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:33:52 +0000
Subject: [PATCHv5 01/16] arm: arch_timer: balance device_node refcounting
In-Reply-To: <1359634539-9580-2-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153352.GG12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:24PM +0000, Mark Rutland wrote:
> When we get the device_node for the arch timer, it's refcount is
> automatically incremented in of_find_matching_node, but it is
> never decremented.
> 
> This patch decrements the refcount on the node after we're finished
> using it.
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

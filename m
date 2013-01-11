From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Jan 2013 18:29:24 +0530
Subject: [PATCHv2 01/11] arm: arch_timer: balance device_node refcounting
In-Reply-To: <1357747640-18594-2-git-send-email-mark.rutland@arm.com>
References: <1357747640-18594-1-git-send-email-mark.rutland@arm.com>
 <1357747640-18594-2-git-send-email-mark.rutland@arm.com>
Message-ID: <50F00CAC.8040709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013 09:37 PM, Mark Rutland wrote:
> When we get the device_node for the arch timer, it's refcount is
> automatically incremented in of_find_matching_node, but it is
> never decremented.
>
> This patch decrements the refcount on the node after we're finished
> using it.
>
> Reported-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
Looks right.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

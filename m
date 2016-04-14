From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 14 Apr 2016 16:20:12 -0700
Subject: [PATCH] ARM: provide improved virt_to_idmap() functionality
In-Reply-To: <E1aqn9y-00012K-8h@rmk-PC.arm.linux.org.uk>
References: <E1aqn9y-00012K-8h@rmk-PC.arm.linux.org.uk>
Message-ID: <571025AC.5010706@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/14/2016 12:42 PM, Russell King wrote:
> For kexec, we need more functionality from the IDMAP system.  We need to
> be able to convert physical addresses to their identity mappped versions
> as well as virtual addresses.
>
> Convert the existing arch_virt_to_idmap() to deal with physical
> addresses instead.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Obviously, this is for Keystone 2 Kexec with its weird physical memory
> layout.
>
Nice !!
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

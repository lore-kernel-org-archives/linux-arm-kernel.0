From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Feb 2014 01:21:00 -0500
Subject: [PATCH] ARCH: mvebu: Makefile clean-up
In-Reply-To: <1388763487-28436-1-git-send-email-gregory.clement@free-electrons.com>
References: <1388763487-28436-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140205062100.GS8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 04:38:07PM +0100, Gregory CLEMENT wrote:
> Some objects depend on CONFIG_ARCH_MVEBU whereas this whole Makefile
> depends on the same symbol. Moreover CONFIG_ARCH_MVEBU can't be
> selected as a module. So we can simplify this Makefile by moving all
> the object from obj-$(CONFIG_ARCH_MVEBU) to obj-y.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Jason,
> 
> This patch is just a cosmetic one and it will conflict with the patch
> fix I have just sent, but the conflict is trivial and I can resubmit
> it as soon as the fix will be part of the 3.13-rc. If it is too late
> for 3.14, just postpone it for 3.15.
> 
> Thanks,
> 
> Gregory
> 
>  arch/arm/mach-mvebu/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to mvebu/soc with s/ARCH/ARM/ and minor conflict resolution for
mvebu-soc-id.o.

thx,

Jason.

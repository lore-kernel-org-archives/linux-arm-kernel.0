From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Tue, 22 Sep 2015 08:51:40 -0700
Subject: [PATCH] MAINTAINERS: Add keystone device tree and defconfig to
 list
In-Reply-To: <1442936378-7538-1-git-send-email-nm@ti.com>
References: <1442936378-7538-1-git-send-email-nm@ti.com>
Message-ID: <5601790C.9080703@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/22/15 8:39 AM, Nishanth Menon wrote:
> Keystone2 architecture files also include defconfig and devicetree
> files which need maintainer to pick up and send for merge. Include the
> same in the MAINTAINERS file so that we know where what needs to go.
>
Well this is I guess assumed responsibility and I have been taking
care of those patches.

> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ba7ab749c85..5a06d3e26c80 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1187,6 +1187,9 @@ ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>   M:	Santosh Shilimkar <ssantosh@kernel.org>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> +F:	arch/arm/boot/dts/k2*
> +F:	arch/arm/boot/dts/keystone*
> +F:	arch/arm/configs/keystone_defconfig
>   F:	arch/arm/mach-keystone/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
>
No harm in adding explicitly if it helps. :-)

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

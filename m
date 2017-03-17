From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 09:59:46 +0000
Subject: [PATCH] ARM: wire up statx syscall
In-Reply-To: <20170317094204.15630-1-chris.packham@alliedtelesis.co.nz>
References: <20170317094204.15630-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170317095945.GY21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You obviously have not looked in linux-next.

Not applying _your_ patch.

On Fri, Mar 17, 2017 at 10:42:04PM +1300, Chris Packham wrote:
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/arm/tools/syscall.tbl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> index 3c2cb5d5adfa..0bb0e9c6376c 100644
> --- a/arch/arm/tools/syscall.tbl
> +++ b/arch/arm/tools/syscall.tbl
> @@ -411,3 +411,4 @@
>  394	common	pkey_mprotect		sys_pkey_mprotect
>  395	common	pkey_alloc		sys_pkey_alloc
>  396	common	pkey_free		sys_pkey_free
> +397	common	statx			sys_statx
> -- 
> 2.11.0.24.ge6920cf
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

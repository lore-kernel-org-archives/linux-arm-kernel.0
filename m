From: saaguirre@ti.com (Aguirre, Sergio)
Date: Tue, 27 Apr 2010 16:14:20 -0500
Subject: [PATCH] arm: Fix .gitignore for boot/compressed folder
In-Reply-To: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
References: <1267113345-18426-1-git-send-email-saaguirre@ti.com>
Message-ID: <A24693684029E5489D1D202277BE894454F780CB@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: Aguirre, Sergio
> Sent: Thursday, February 25, 2010 9:56 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org; Albin Tonnerre; Russell King; Aguirre,
> Sergio
> Subject: [PATCH] arm: Fix .gitignore for boot/compressed folder
> 
> This should complements changes done in:
> 
>   commit e7db7b4270ed2a606b8c0b5f944a5f92ade0e84c
>   Author: Albin Tonnerre <albin.tonnerre@free-electrons.com>
>   Date:   Fri Jan 8 14:42:43 2010 -0800
> 
>       arm: add support for LZO-compressed kernels
> 
> It missed to do the respective changes in '.gitignore' file.

Any comments on this patch?

I see no feedback, and still a dirty index everytime I build...

Regards,
Sergio

> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
> ---
>  arch/arm/boot/compressed/.gitignore |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/.gitignore
> b/arch/arm/boot/compressed/.gitignore
> index ab204db..bb984af 100644
> --- a/arch/arm/boot/compressed/.gitignore
> +++ b/arch/arm/boot/compressed/.gitignore
> @@ -1,3 +1,5 @@
>  font.c
> -piggy.gz
> +piggy.gzip
> +piggy.lzo
> +lib1funcs.S
>  vmlinux.lds
> --
> 1.6.3.3

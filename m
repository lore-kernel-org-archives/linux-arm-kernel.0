From: julien.grall@arm.com (Julien Grall)
Date: Thu, 15 Dec 2016 11:34:05 +0000
Subject: [PATCH v2 1/4] Support for building in a Xen binary
In-Reply-To: <20161122150917.16524-2-andre.przywara@arm.com>
References: <20161122150917.16524-1-andre.przywara@arm.com>
 <20161122150917.16524-2-andre.przywara@arm.com>
Message-ID: <4df45802-b8f2-b566-9106-22b31b7898eb@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On 22/11/16 15:09, Andre Przywara wrote:
> diff --git a/configure.ac b/configure.ac
> index ab8f5b3..f7e24c7 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -40,6 +40,18 @@ AC_ARG_WITH([dtb],
>  	AS_HELP_STRING([--with-dtb], [Specify a particular DTB to use]),
>  	[KERN_DTB="$withval"])
>
> +AC_ARG_WITH([xen],
> +	AS_HELP_STRING([--with-xen], [Compile for Xen, and Specify a particular Xen to use]),

NIT: s/Specify/specify/

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall

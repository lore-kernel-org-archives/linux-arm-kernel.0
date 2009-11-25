From: acassis@gmail.com (Alan Carvalho de Assis)
Date: Wed, 25 Nov 2009 11:40:09 -0200
Subject: [PATCH v3] mx27: Add basic support for Maxtrack i-MXT TD60
In-Reply-To: <37367b3a0911250434k4c864fbt429d83a41a06f3d8@mail.gmail.com>
References: <37367b3a0911250434k4c864fbt429d83a41a06f3d8@mail.gmail.com>
Message-ID: <37367b3a0911250540g4f8a1829mace97f87bc08ab7b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
> ...
> --- a/arch/arm/plat-mxc/include/mach/uncompress.h
> +++ b/arch/arm/plat-mxc/include/mach/uncompress.h
> @@ -86,6 +86,9 @@ static __inline__ void __arch_decomp_setup(unsigned
> long arch_id)
>  	case MACH_TYPE_PCA100:
>  		uart_base = MX2X_UART1_BASE_ADDR;
>  		break;
> +	case MACH_TYPE_MXT_TD60:
> +		uart_base = MX2X_UART1_BASE_ADDR;
> +		break;

Oops, I duplicated entries at case switch :-/

Fixing...

Alan

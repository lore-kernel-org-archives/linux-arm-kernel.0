From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 Jul 2014 20:23:06 +0800
Subject: [patch] [ARM] pxa: remove duplicate SM_SCLK_SM_SCLK define
In-Reply-To: <20140609151343.GH9600@mwanda>
References: <20140609151343.GH9600@mwanda>
Message-ID: <CAN1soZwjwD0LGjt65K-taMBhW_148FPeeRCMU=5hx48niSw_Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 9, 2014 at 11:13 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> The SM_SCLK_SM_SCLK is define is cut and pasted twice.  I have removed
> the second define.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> index fbd7ee8..8c78f2b1 100644
> --- a/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/mfp-pxa910.h
> @@ -23,7 +23,6 @@
>  #define SM_nCS0_nCS0           MFP_CFG(SM_nCS0, AF0)
>  #define SM_ADV_SM_ADV          MFP_CFG(SM_ADV, AF0)
>  #define SM_SCLK_SM_SCLK                MFP_CFG(SM_SCLK, AF0)
> -#define SM_SCLK_SM_SCLK                MFP_CFG(SM_SCLK, AF0)
>  #define SM_BE0_SM_BE0          MFP_CFG(SM_BE0, AF1)
>  #define SM_BE1_SM_BE1          MFP_CFG(SM_BE1, AF1)
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

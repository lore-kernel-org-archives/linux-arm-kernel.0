From: scott.wood@nxp.com (Scott Wood)
Date: Thu, 24 Nov 2016 08:21:15 +0000
Subject: [PATCH v3] clk: qoriq: added ls1012a clock configuration
References: <1479955015-37514-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <DB5PR0401MB1928925ACE6E6E066961C64A91B60@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 08:50 PM, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
> ---
> v3:
>   - rebased to latest kernel and re-sorted the code
[snip]
> @@ -1316,6 +1334,7 @@ CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
> +CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);

You need a better sorting algorithm. :-P

-Scott

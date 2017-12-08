From: leoyang.li@nxp.com (Li Yang)
Date: Fri, 8 Dec 2017 16:21:28 -0600
Subject: [PATCH] soc: fsl: support GUTS driver for ls1012a/ls1046a
In-Reply-To: <20171207083615.17689-1-yangbo.lu@nxp.com>
References: <20171207083615.17689-1-yangbo.lu@nxp.com>
Message-ID: <CADRPPNTBUzbMFvLRCdZYrqmT7aJUJBG6e72EN1Qi0M8AHPNKtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 2:36 AM, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> This patch is to add compatible strings "fsl,ls1021a-dcfg" and
> "fsl,ls1043a-dcfg" into device match table of GUTS driver.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
>  drivers/soc/fsl/guts.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index d89a6a80c8ef..d98de2c76659 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -214,6 +214,8 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1043a-dcfg", },
>         { .compatible = "fsl,ls2080a-dcfg", },
>         { .compatible = "fsl,ls1088a-dcfg", },
> +       { .compatible = "fsl,ls1012a-dcfg", },
> +       { .compatible = "fsl,ls1046a-dcfg", },

Looks good.  Merged.

Regards,
Leo

From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 Nov 2018 13:51:57 -0200
Subject: [PATCH V5 3/6] ARM: imx: add initial support for imx7ulp
In-Reply-To: <1541862478-7839-4-git-send-email-aisheng.dong@nxp.com>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
 <1541862478-7839-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5A1R-aoDg5d9OLApArz51daaKcpfyDYJH9hWPnjKCH5=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 1:14 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> +static void __init imx7ulp_init_machine(void)
> +{
> +       imx7ulp_pm_init();
> +
> +       mxc_set_cpu_type(MXC_CPU_IMX7ULP);
> +       /* FIXME: so far there is still no way to retrieve SoC version */
> +       imx_print_silicon_rev("i.MX7ULP", IMX_CHIP_REVISION_UNKNOWN);

Then maybe just do not call imx_print_silicon_rev() for now?

Anyway:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

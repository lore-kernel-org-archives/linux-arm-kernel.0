From: scott.wood@nxp.com (Scott Wood)
Date: Fri, 18 Mar 2016 22:54:46 +0000
Subject: [v6, 2/5] soc: fsl: add GUTS driver for QorIQ platforms
References: <1457518131-11339-1-git-send-email-yangbo.lu@nxp.com>
 <1457518131-11339-3-git-send-email-yangbo.lu@nxp.com>
Message-ID: <DB5PR0401MB1928302BB0DDE8D9B47E4361918C0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/2016 04:18 AM, Yangbo Lu wrote:
> +#ifdef CONFIG_FSL_GUTS
> +u32 fsl_guts_get_svr(void);
> +int fsl_guts_init(void);
> +#endif

Don't ifdef prototypes (when not providing a stub alternative).

-Scott

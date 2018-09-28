From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 28 Sep 2018 13:49:42 +0000
Subject: [PATCH V7 3/3] firmware: imx: add misc svc support
In-Reply-To: <20180928061109.xxbrxsjpgizurhfl@pengutronix.de>
References: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
 <1537892878-30933-4-git-send-email-aisheng.dong@nxp.com>
 <20180928061109.xxbrxsjpgizurhfl@pengutronix.de>
Message-ID: <AM0PR04MB42113697CF45EBF3A87DDF6980EC0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > +sc_err_t sc_misc_set_control(struct sc_ipc *ipc, sc_rsrc_t resource,
> > +			     sc_ctrl_t ctrl, uint32_t val)
> 
> > +sc_err_t sc_misc_get_control(struct sc_ipc *ipc, sc_rsrc_t resource,
> > +			     sc_ctrl_t ctrl, uint32_t *val)  */ enum misc_func_e {
> > +	MISC_FUNC_UNKNOWN = 0,
> 
> The exported functions enums and structs should have a proper prefix.
> 

Got it, will update it. Thanks

Regards
Dong Aisheng

> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Cad
> 06bc6bc8e84d57b9db08d62509307f%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636737118739395981&amp;sdata=bz3zHNdjIhOwYrgptQC
> U0MbntRjjRbARkWOWU2Asxjg%3D&amp;reserved=0  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:
> +49-5121-206917-5555 |

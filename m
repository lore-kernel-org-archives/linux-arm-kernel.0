From: B32955@freescale.com (Huang Shijie-B32955)
Date: Mon, 13 Feb 2012 15:48:05 +0000
Subject: =?big5?B?tarOYDogtarOYDogW1BBVENIXSBtdGQvZ3BtaSA6IGFkZCBncG1pIHN1cHBvcnQg?=
 =?big5?Q?for_mx6q?=
In-Reply-To: <1329147404.22240.178.camel@sauron.fi.intel.com>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>	,
 <1329134454.22240.114.camel@sauron.fi.intel.com>
 <14C4E31473AF7E4B98176CB73615181C362D9F@039-SN1MPN1-006.039d.mgd.msft.net>,
 <1329147404.22240.178.camel@sauron.fi.intel.com>
Message-ID: <14C4E31473AF7E4B98176CB73615181C363DF6@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

>scripts/kconfig/conf --savedefconfig=defconfig Kconfig
>warning: (MTD_NAND_GPMI_NAND) selects MTD_CMDLINE_PARTS which has unmet direct dependencies (MTD=y)

>Would mxs people send a fix?

Do you mean i have to remove the "select MTD_CMD_LINE_PARTS" for gpmi-nand?

BR
Huang Shijie

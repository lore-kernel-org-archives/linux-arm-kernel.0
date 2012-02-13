From: B32955@freescale.com (Huang Shijie-B32955)
Date: Mon, 13 Feb 2012 15:05:55 +0000
Subject: =?big5?B?tarOYDogW1BBVENIXSBtdGQvZ3BtaSA6IGFkZCBncG1pIHN1cHBvcnQgZm9yIG14?=
 =?big5?Q?6q?=
In-Reply-To: <1329134454.22240.114.camel@sauron.fi.intel.com>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>,
 <1329134454.22240.114.camel@sauron.fi.intel.com>
Message-ID: <14C4E31473AF7E4B98176CB73615181C362D9F@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem:

>Please, let me know how I can compile-test this. This diver depends on
>imx23 or imx28 and I cannot find a defconfig for these. When I select
>MXS platform the compilation fails. Could you please describe some way
>to generate a compilable configuration which would include this driver
>as well, or send me the defconfig file.

use make mxs_defconfig to make the .config.
and select the gpmi-nand driver. then you can compile it.

This patch is just part of the patches for mx6q, another two patches are the mxs-dma patches.
So in the mx6q, I do not enable the  gpmi-nand driver. you can compile-test it just on mxs_defconfig.

BR
Huang Shijie

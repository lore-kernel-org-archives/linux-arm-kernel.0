From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 13 Apr 2016 00:31:46 +0200
Subject: [PATCH v5 34/50] mtd: nand: gpmi: switch to mtd_ooblayout_ops
In-Reply-To: <DB5PR0401MB1845A6EE26FD2734CDBBE20F97950@DB5PR0401MB1845.eurprd04.prod.outlook.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-35-git-send-email-boris.brezillon@free-electrons.com>
 <DB5PR0401MB1845A6EE26FD2734CDBBE20F97950@DB5PR0401MB1845.eurprd04.prod.outlook.com>
Message-ID: <20160413003146.4deb6017@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2016 22:27:58 +0000
Han Xu <han.xu@nxp.com> wrote:

> 
> I am fine with all gpmi patch set and tested on i.MX6Q, just found another issue in gpmi driver.
> The patch was sent, refer to https://patchwork.ozlabs.org/patch/609755/

Oh, was it related to the changes introduced by this series?

> 
> 
> Acked-by: Han Xu <han.xu@nxp.com>
> Tested-by: Han Xu <han.xu@nxp.com>
> --
> 2.5.0
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

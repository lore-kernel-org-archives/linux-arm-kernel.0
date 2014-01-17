From: silvio@port1024.net (Silvio F.)
Date: Fri, 17 Jan 2014 10:27:24 +0100
Subject: [PATCH] ARM: imx6: dmo edmqmx6 updates
In-Reply-To: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
References: <1389876750-29880-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20140117092724.GB28973@sfrouter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> This series adds some additional features to the recently introduced
> DataModul edmqmx6 board.
> 
> Sascha
> 
> ----------------------------------------------------------------
> Philipp Zabel (1):
>       ARM: dts: imx6: edmqmx6: add PF0100 PMIC to device tree
> 
> Sascha Hauer (3):
>       ARM: dts: imx6: edmqmx6: Add usdhc4 (emmc) support
>       ARM: dts: imx6: edmqmx6: Add sata support
>       ARM: dts: imx6: edmqmx6: Add LED support
> 
>  arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 148 ++++++++++++++++++++++++++++++++
>  1 file changed, 148 insertions(+)
> 

For the complete patchset:

Tested-by: Silvio F. <silvio@port1024.net>
Acked-by: Silvio F. <silvio@port1024.net>


Cheers,
    Silvio

-- 
-- S. Fricke ---------------------------------------- silvio at port1024.net --
   Diplom-Informatiker (FH)
   Linux-Entwicklung             JABBER: silvio at conversation.port1024.net   
----------------------------------------------------------------------------

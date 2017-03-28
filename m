From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Mar 2017 18:41:19 +0800
Subject: [PATCH] arm64: dts: ls1012a: add crypto node
In-Reply-To: <VI1PR0401MB259164F1B575677D65CB8F2E98320@VI1PR0401MB2591.eurprd04.prod.outlook.com>
References: <20170322122939.22117-1-horia.geanta@nxp.com>
 <20170324015606.GC30608@dragon>
 <DB4PR04MB0847D837CB2762D5094720CB983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
 <20170324073420.GM30608@dragon>
 <DB4PR04MB0847E3EE8F7FAC11DD85FAA8983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
 <20170324140320.GP30608@dragon>
 <VI1PR0401MB259164F1B575677D65CB8F2E98320@VI1PR0401MB2591.eurprd04.prod.outlook.com>
Message-ID: <20170328104115.GT30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 07:19:43AM +0000, Horia Geant? wrote:
> For the sake of current patch, please clarify whether a v2 is needed.
> IIUC:
> -sec_mon node name could stay the same (existing binding)
> -label names are ok, since underline is the only option allowed by DTC
> -alias names are out-of-spec but accepted by DTC; if changing underline
> to hyphen is requested, I will push out v2

All these are fine.  But we agreed that the alias definitions can be
shared and should be moved to fsl-ls1012a.dtsi, right?

Shawn

From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 24 Mar 2017 15:34:23 +0800
Subject: [PATCH] arm64: dts: ls1012a: add crypto node
In-Reply-To: <DB4PR04MB0847D837CB2762D5094720CB983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
References: <20170322122939.22117-1-horia.geanta@nxp.com>
 <20170324015606.GC30608@dragon>
 <DB4PR04MB0847D837CB2762D5094720CB983E0@DB4PR04MB0847.eurprd04.prod.outlook.com>
Message-ID: <20170324073420.GM30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 07:17:50AM +0000, Horia Geant? wrote:
> >> +		sec_mon: sec_mon at 1e90000 {
> > 
> > Hyphen is more preferred to be used in node name than underscore.
> > 
> This would imply changing the
> Documentation/devicetree/bindings/crypto/fsl-sec4.txt binding and
> dealing with all the consequences, which IIUC is probably not worth.

I do not care the bindings doc that much, since I'm not the maintainer
of it.  What are the consequences specifically, if we use a better node
name in dts than bindings example?

Shawn

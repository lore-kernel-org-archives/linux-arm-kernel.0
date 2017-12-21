From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 15:32:17 +0800
Subject: [PATCH 1/2][v2] ARM: dts: Add big-endian for IFC on LS1021A
In-Reply-To: <HE1PR04MB1241243DE5FE86833DD0B509970D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
References: <1512013344-4042-1-git-send-email-prabhakar.kushwaha@nxp.com>
 <1512013344-4042-2-git-send-email-prabhakar.kushwaha@nxp.com>
 <HE1PR04MB1241E7538E97597B76606FF4970D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <20171221071056.GF3766@dragon>
 <HE1PR04MB1241243DE5FE86833DD0B509970D0@HE1PR04MB1241.eurprd04.prod.outlook.com>
Message-ID: <20171221073216.GC23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 07:19:12AM +0000, Prabhakar Kushwaha wrote:
> Are you referring to this discussion https://patchwork.ozlabs.org/patch/842543/?
>  Due to which binding are not ACK-ed.

Hmm, I'm talking about Rob's comment below.

https://www.spinics.net/lists/arm-kernel/msg620518.html

In any case, I cannot apply the dts change before the bindings part gets
ACK-ed by DT maintainer.

Shawn

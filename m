From: adam.cottrel@veea.com (Adam Cottrel)
Date: Mon, 15 Oct 2018 15:51:21 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <20181015153926.GC8789@hc>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
 <b56bf98f-5055-fb85-7807-e45d495369f3@arm.com>
 <DM6PR04MB405918E803AF4FCC34B12083F2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181015150912.GA8789@hc>
 <DM6PR04MB4059991247828ADBD6133D2FF2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181015153926.GC8789@hc>
Message-ID: <DM6PR04MB405906FA74124FFEBCA9188AF2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jan,

> I'm not sure where that point would be where DMA request could be lost
> here.
> The MMC and PCIe only meet in the NCB (near coprocessor bus) which goes
> to the Coherent memory interconnect and L2 cache.
> 
> I've looked for any known errata but didn't find anything that would match
> your problem.

For the purposes of debug, is it possible for me to turn off the MMC? Or the L2 cache? Or put it into pass through mode? Or get any kind of stack trace on its operation?

Best,
Adam

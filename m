From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Nov 2009 18:18:30 +0100
Subject: [PATCH 2/3 v2] mmc: atmel-mci: New MCI2 module support in
	atmel-mci driver
In-Reply-To: <af570068c8bd25f207dd3a43b8acd7cf645b21af.1256314995.git.nicolas.ferre@atmel.com>
References: <20090930155557.7dae503b@hskinnemoen-d830>
	<af570068c8bd25f207dd3a43b8acd7cf645b21af.1256314995.git.nicolas.ferre@atmel.com>
Message-ID: <4AEF1466.8090203@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

What do you think about the rework of this atmel-mci DMA interface ?
patches:
[PATCH 1/3 v2] atmel-mci: change use of dma slave interface
[PATCH 2/3 v2] mmc: atmel-mci: New MCI2 module support in atmel-mci driver

We may consider them in replacement of the previous ones and dissociate 
this series from the third one which will be reworked and may goes through 
using another path.
(for the record: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc 
driver in at91sam9g45 chip and board).

Thanks,

Bye,
-- 
Nicolas Ferre

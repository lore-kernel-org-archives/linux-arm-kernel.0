From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 12 May 2010 23:21:54 +0100
Subject: Rampant ext3/4 corruption on 2.6.34-rc7 with VIVT ARM (Marvell
	88f5182)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
References: <1273569821.21352.19.camel@pasglop>
	<1273575478.21352.29.camel@pasglop>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C545537F@dbde02.ent.ti.com>
Message-ID: <20100512222154.GA6841@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shilimkar, Santosh wrote:
> There was a memory write barrier missing before the DMA descriptors 
> are handed over to DMA controller.

On that note, are the cache flush functions implicit memory barriers?

-- Jamie

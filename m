From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 17:17:30 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <20141201115006.08197c40@bbrezillon>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <19172687.eVxczUuuhC@ws-stein> <20141201115006.08197c40@bbrezillon>
Message-ID: <2417519.MDE3mu6n7n@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 11:50:06 Boris Brezillon wrote:
> 
> I don't have a strong opinion regarding where this driver should
> live (I even considered putting it in drivers/bus) :-).
> But note that there are other "external memory interface" drivers
> in drivers/memory too: TI AEMIF and Marvell DEVBUS  ;-).
> 
> Does anyone else think this driver should go in drivers/bus ?
> 

I think drivers/memory is better.

	Arnd

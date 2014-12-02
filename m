From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 02 Dec 2014 10:18:45 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <2417519.MDE3mu6n7n@wuerfel>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <20141201115006.08197c40@bbrezillon> <2417519.MDE3mu6n7n@wuerfel>
Message-ID: <1724175.Jqk8gQW3pz@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 17:17:30, Arnd Bergmann wrote:
> On Monday 01 December 2014 11:50:06 Boris Brezillon wrote:
> > 
> > I don't have a strong opinion regarding where this driver should
> > live (I even considered putting it in drivers/bus) :-).
> > But note that there are other "external memory interface" drivers
> > in drivers/memory too: TI AEMIF and Marvell DEVBUS  ;-).
> > 
> > Does anyone else think this driver should go in drivers/bus ?
> > 
> 
> I think drivers/memory is better.

I don't mind if it's drivers/bus or drivers/memory. But I'm wondering: When is a driver a bus driver when it is a memory driver? See imx-weim and atmel-ebi. Apparently both add support for devices attached on a bus which can be accessed through memory addresses :)

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein at systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

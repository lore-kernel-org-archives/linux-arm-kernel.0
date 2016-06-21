From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 Jun 2016 22:52:47 -0700
Subject: [GIT PULL] drivers: firmware: scpi updates for v4.8
In-Reply-To: <5768022D.2010506@arm.com>
References: <5768022D.2010506@arm.com>
Message-ID: <20160621055247.GC24293@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 03:48:13PM +0100, Sudeep Holla wrote:
> Hi ARM-SoC team,
> 
> Here are few updates for SCPI drivers for v4.8. The DT binding have been
> ACKed by DT maintainer.
> 
> Also as most of the genpd code is in drivers/soc and SCPI can be used on
> any SoC, runtime PM maintainer agreed to keep the SCPI genpd based power
> domain driver in drivers/firmware for now. It also carries their
> ACK.

Am I missing something here? The only Acked-by I see on any patch is the one
from Mark Rutland on the bindings.


-Olof

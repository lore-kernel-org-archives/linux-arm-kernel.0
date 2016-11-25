From: slash.tmp@free.fr (Mason)
Date: Fri, 25 Nov 2016 15:05:05 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1xa8cnai0p.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <yw1xa8cnai0p.fsf@unicorn.mansr.com>
Message-ID: <ae97a212-a91e-5e0a-c9b6-2dba3b79ddc5@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/2016 12:57, M?ns Rullg?rd wrote:

> The same DMA unit is also used for SATA, which is an off the shelf
> Designware controller with an in-kernel driver.  This interrupt timing
> glitch can actually explain some intermittent errors I've observed with
> it.

FWIW, newer chips embed an AHCI controller, with a dedicated
memory channel.

FWIW2, the HW dev said memory channels are "almost free", and he
would have no problem giving each device their own private channel
read/write pair.

Regards.

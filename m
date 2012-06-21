From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Jun 2012 16:11:56 +0200
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex
Message-ID: <20120621141156.GA12038@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Without the clock patch:
> - No NAND definitions anywhere - doesn't complete a boot
> - NAND defined and initialized in board-goflexnet.c - complete boot
> with NAND accessible
> - NAND defined via DT - doesn't complete a boot, stops at same point
> as with no NAND definitions

I'm surprised about the last. Is MTD finding the NAND device and
creating the partitions and devices?

> To move forward, do I assume the clock patch is going to be pulled
> into mainline and submit my patch as depending on it, with NAND
> defined in the DT, or for now submit with it defined and initialized
> via the board file until the DT issue can be resolved?

The patch has been accepted and should appear in the next -rc.

    Andrew

From: davem@davemloft.net (David Miller)
Date: Fri, 23 Sep 2016 22:45:53 -0400 (EDT)
Subject: Alignment issues with freescale FEC driver
In-Reply-To: <bc19d934-f50b-50d6-0f4f-ecfcb8a2a1c9@nelint.com>
References: <0fe7a310-2d2f-4fca-d698-85d66122d91c@nelint.com>
 <20160923181301.GD22965@lunn.ch>
 <bc19d934-f50b-50d6-0f4f-ecfcb8a2a1c9@nelint.com>
Message-ID: <20160923.224553.1824171056324385383.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Nelson <eric@nelint.com>
Date: Fri, 23 Sep 2016 11:35:17 -0700

> From the i.MX6DQ reference manual, bit 7 of ENET_RACC says this:
> 
> "RX FIFO Shift-16
> 
> When this field is set, the actual frame data starts at bit 16 of the first
> word read from the RX FIFO aligning the Ethernet payload on a
> 32-bit boundary."
> 
> Same for the i.MX6UL.
> 
> I'm not sure what it will take to use this, but it seems to be exactly
> what we're looking for.

+1

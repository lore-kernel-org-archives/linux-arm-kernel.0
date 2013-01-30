From: lznuaa@gmail.com (Frank Li)
Date: Wed, 30 Jan 2013 09:55:03 +0800
Subject: [PATCH v4 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <20130129.141800.2181207237672109119.davem@davemloft.net>
References: <1359433903-15605-1-git-send-email-Frank.Li@freescale.com>
 <20130129.141800.2181207237672109119.davem@davemloft.net>
Message-ID: <CAHrpEqQXH+n7K4L1m5yRiamp3CG9MPWhX+tNBD+brzArJy5WoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/30 David Miller <davem@davemloft.net>:
> it is recommended to also to TX reclaim processing
> in the NAPI handler as well, in fact it's best to make the hardware
> interrupt handler do nothing other than trigger NAPI and then
> move everything that was in your hardware interrupt handler into
> NAPI poll instead.

Okay, I will work on this soon.

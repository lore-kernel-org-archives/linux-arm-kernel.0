From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 Sep 2014 16:49:05 +0200
Subject: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <20140922130351.GL5182@n2100.arm.linux.org.uk>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
 <CAE0=X_0VQ8rWrUgbsgKm1MwCP8bwWm3UJPq9p=xNDfjP4CC7Bg@mail.gmail.com>
 <20140922095939.GB1406@katana>
 <20140922130351.GL5182@n2100.arm.linux.org.uk>
Message-ID: <20140922144904.GA1465@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 02:03:51PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 22, 2014 at 11:59:39AM +0200, Wolfram Sang wrote:
> > IRQ_NONE is "this interrupt wasn't by me" so for shared IRQs, the next
> > handler can check.
> 
> Err, no it isn't.  IRQ_NONE has no such effect.  All handlers on a
> shared interrupt are always run irrespective of the return value from
> any particular interrupt handler.  See kernel/irq/handle.c.

/me picks the brown paper bag. I was sure I did. Need to update my
notes, it seems. Thanks for the heads up!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/ea2da8ea/attachment.sig>

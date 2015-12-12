From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 12 Dec 2015 18:13:55 +0100
Subject: touchscreen: edt-ft5x06: Prevent DMA driver from mapping an area
 on stack
In-Reply-To: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
References: <e0311a5e79a315814e8678c9ef4a32563c01d1e0.1449913392.git.maitysanchayan@gmail.com>
Message-ID: <20151212171355.GA7362@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Frankly speaking I do not know where the fix should actually be. I2C IMX
> driver somehow taking care of this or the users of I2C, touchscreen drivers
> in this case. In my opinion, the fix should be with the touchscreen driver
> however I did like to have feedback or hear opinions on what is the accepted
> solution to this.

There is no accepted solution to this yet :( DMA is/was still too rare for
a serious discussion about this. There is also [1] and probably more...

[1]  http://patchwork.ozlabs.org/patch/220137/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151212/cc0d487a/attachment.sig>

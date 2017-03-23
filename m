From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 23 Mar 2017 21:42:06 +0100
Subject: [PATCH 3/5] i2c: i2c-stm32f7: add driver
In-Reply-To: <CAOAejn383=Zk42nnJoG=qP=uEHpzEwf=5dePx_atyzWGDGBiyA@mail.gmail.com>
References: <1489744738-21632-1-git-send-email-cedric.madianga@gmail.com>
 <1489744738-21632-4-git-send-email-cedric.madianga@gmail.com>
 <20170323201719.i5bqrbxr2bejopky@ninjato>
 <CAOAejn383=Zk42nnJoG=qP=uEHpzEwf=5dePx_atyzWGDGBiyA@mail.gmail.com>
Message-ID: <20170323204206.daxgcczep2daxqet@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Yes the STM32F7 has a new I2C IP core compared to STM32F4.
> The engine, the machine state are very different.
> I tried few months ago to write a common driver but it was very very
> difficilcut as the 2 IP are not so much things in common.

Good, thanks for the heads up!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170323/dc03e3c5/attachment-0001.sig>

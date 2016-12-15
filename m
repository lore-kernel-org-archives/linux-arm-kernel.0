From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Dec 2016 20:40:02 +0100
Subject: [PATCH v6 2/5] i2c: Add STM32F4 I2C driver
In-Reply-To: <20161215193307.436sggu4zy4zezoe@pengutronix.de>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-3-git-send-email-cedric.madianga@gmail.com>
 <20161213092031.d2ax2pnpzzicriel@pengutronix.de>
 <CAOAejn0Ej90amOZUC2wGNBsTAZVmcqEaViV1-TeoaspiADBkkg@mail.gmail.com>
 <20161215193307.436sggu4zy4zezoe@pengutronix.de>
Message-ID: <20161215194001.GA1741@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> I thought (but I could be wrong) that if the driver is called
> "stm32f4-i2c", it is used to match "st,stm32f4-i2c" even without
> .of_match_table. If this doesn't work, please disregard my question.

This currently works only for *i2c client drivers*, it never did for i2c
adapters. And even for clients, this behaviour is going to be deprecated
somewhen. There are people working on it...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/46d9fc21/attachment-0001.sig>

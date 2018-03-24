From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 25 Mar 2018 00:25:21 +0100
Subject: [PATCH v5 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
In-Reply-To: <20180324231910.unzvwty3xia4mqu2@ninjato>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
 <20180302083123.7259-3-ard.biesheuvel@linaro.org>
 <20180324231910.unzvwty3xia4mqu2@ninjato>
Message-ID: <20180324232521.ofzk3fikda42ywep@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My code checkers mention this:

    CPPCHECK
drivers/i2c/busses/i2c-synquacer.c:422: style: Checking if unsigned variable 'timeout' is less than zero.


  CC      drivers/i2c/busses/i2c-synquacer.o
drivers/i2c/busses/i2c-synquacer.c: In function ?synquacer_i2c_probe?:
drivers/i2c/busses/i2c-synquacer.c:678:15: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if (i2c->irq < 0) {
               ^
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180325/d33dc6e8/attachment-0001.sig>

From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Oct 2014 18:48:52 +0200
Subject: [PATCH v3 2/3] i2c: hix5hd2: add i2c controller driver
In-Reply-To: <542EA15B.70605@linaro.org>
References: <1412079628-6316-1-git-send-email-zhangfei.gao@linaro.org>
 <1412079628-6316-3-git-send-email-zhangfei.gao@linaro.org>
 <20141003120926.GF1349@katana> <542EA15B.70605@linaro.org>
Message-ID: <20141003164851.GA1481@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Currently Wei help do the test via I2C device interface, on a specific board
> with i2c device.
> We do the test after the board is up, also no i2c activity during probe.

Huh, so the driver has not been tested with a real i2c slave so far? Or
am I misunderstanding something?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141003/ff37924e/attachment.sig>

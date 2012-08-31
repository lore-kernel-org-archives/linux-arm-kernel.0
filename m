From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Aug 2012 16:00:39 +0200
Subject: [PATCHv2] Introduce the CFA-10049 expansion board
Message-ID: <1346421641-3765-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Here is a patchset to introduce the CFA-10049 expansion board to the CFA-10036
module.

This expansion board has a number of ADCs and DACs, stepper drivers, GPIO
expanders, a LCD touchscreen and fans. Support for those will come eventually.

We only support the I2C bus for now, that is used for ADCs behind a i2c muxer
and a GPIO expander.


Thanks,
Maxime

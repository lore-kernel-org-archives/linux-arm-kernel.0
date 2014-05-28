From: andreas2025@gmail.com (Andy Ng)
Date: Wed, 28 May 2014 23:18:28 +0100
Subject: IMX6 and SDMA on EIM bus
Message-ID: <CAAVaN8y_P6oY8MpOA=_41mR8Ks_p2KwTTuwpOJmWfbanG1wRxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I try to use  external SDMA trigger events to push data from the RAM
to EIM bus on imx6.
I have set up a device_prep_slave_sg  of a scatter gather lists to get
the buffers out. I am using IMX_DMATYPE_EXT,
transfer type which corresponds to mcu_2_app. Every time there is an
external event, the SDMA makes some dma progress. However, I don't see
any data arriving to the EIM bus. I have the impression that I am
using the wrong ROM script, as mcu_2_app may have code to access the
Peripheral DMA

Does anyone have tried to SDMA transfers from RAM to EIM bus and with
use of external events?
And in order to be more specific. my destination EIM address is a fixed one.

Any advice will be very much appreciated.

Andreas

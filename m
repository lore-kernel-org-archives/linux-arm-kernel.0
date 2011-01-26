From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 26 Jan 2011 12:24:36 +0100
Subject: SDMA on imx35
Message-ID: <201101261224.37260.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm currently fiddling on SDMA support for the uart driver on my imx35 rev2. 
TX is working great, no problems so far. But on RX I never get the SDMA 
interrupt that the request has been processed.
So I'm wondering if the UART-DMS-Script in ROM is actually working. Has 
anybody get this to work (doesn't matter if linux-2.6 from git or kernel from 
freescale)?

Best regards,
Alexander

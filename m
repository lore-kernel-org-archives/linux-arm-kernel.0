From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 14 Feb 2012 10:26:06 +0100
Subject: How to deal with a PHY configuration related to the board?
Message-ID: <20120214092606.GE4723@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I am using a Micrel KSZ9021RN PHY and I would like to configure some registers
as 'RGMII Clock and Control Pad Skew' and 'RGMII RX Data Pad Skew'.
So the values of these registers are board dependant and I wondering what is
the proper way to set them.
It seems there is no platform data usable for this case. Having a quick look
to other PHYs, the situation seems the same.

Can you give me some clues about how to do this? Did I miss anything which
allow to do this?

Thanks

Regards

Ludovic

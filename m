From: ben@datarespons.no (=?iso-8859-1?Q?Bj=F8rn_Erik_Nilsen?=)
Date: Tue, 17 Dec 2013 19:28:27 +0100
Subject: imx6 power consumption
Message-ID: <mailman.18.1387304936.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have measured power consumption for imx6 in mem mode on the 3.12.4 mainstream kernel vs. 3.0.35 kernel from freescale/boundary devices. I noticed a significant increase going from 3.0 to 3.12 . I have at least identified one big difference: DDR is no longer tri-stated, which accounts for some of the difference.

I use 'echo mem > /sys/power/state' for my test case.

Do you know if someone is looking into this issue, or if there are pending patches somewhere?

Best regards,
Bj?rn Erik Nilsen

From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Sun, 6 Jul 2014 19:56:27 -0700
Subject: Issue found in Armada 370: 10Mbps ethernet connection can't get IP
Message-ID: <CAB8gEUtaKwE5ax8_-+jb4pS08CO0V_CFdcEW47ej5YLaU=sb5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
Good day.

We have previously discussed before on Armada 370 ethernet issues (now
resolved via your suggestion/patches in recent kernel versions).

We just found out last week that 10Mbps ethernet (SGMII) connection
can't obtain IP in recent kernel versions (3.10.x and above). Here are
the details:

Processor: Armada 370 88F6707
Board: Custom
Kernel versions tried:
3.10.24 (issue exists)
3.13.9 (issue exists)
3.2.43 (issue does NOT exist)
U-Boot versions tried: 2012_Q4 and 2013_Q1 from Marvell extranet

Some more important notes:
Both 100Mbps and 1000Mbps have no issues.
Issue does not exist at u-boot level (via static IP address, confirmed
via ping - results: 'x.x.x.x is alive')
We have different LED configs for 10, 100 and 1000 Mbps - and LED
shows 10Mbps is established (even ethtool does). However, we just
can't obtain IP.
Our kernel version 3.2.43 have patches from Marvell extranet (for Armada 370)

Is there a known issue for this?

Thank you very much.

Regards,
Maggie Roxas

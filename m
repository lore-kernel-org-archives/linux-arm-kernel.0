From: joerg.krause@embedded.rocks (=?ISO-8859-1?Q?J=F6rg?= Krause)
Date: Thu, 13 Oct 2016 01:09:13 +0200
Subject: Low network throughput on i.MX28
Message-ID: <1476313753.2065.11.camel@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using a custom i.MX28 board similar to the i.MX28-EVK. For Wi-Fi
the board assembles a BCM43362 from Broadcom and for Ethernet a
LAN8720A from Microchip. The board is running mainline Linux 4.7.

While both, wireless and wired network interfaces work, the TCP
throughput measured with iperf is low.

The bandwith for Ethernet is between 20-30 MBits/sec and for WLAN is
about 4-5 MBits/sec.

There exists an Application Note "i.MX28 Ethernet Performance on
Linux" [1] which shows a bandwith of > 60 MBits/sec. A user an the NXP
forum [2] told he achieved 20 MBits/sec with some Qualcom chip.

Note, that these values are most probably measured with the legacy
Linux Kernel 2.6.35 from NXP.

Does anybody has done throughput tests on i.MX28 with mainline Kernel?
If so, what are the results? What might be the bottleneck?

[1] http://cache.freescale.com/files/32bit/doc/app_note/AN4544.pdf
[2] https://community.nxp.com/thread/353921

Best regards
J?rg Krause

From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 18 Apr 2011 11:23:32 +0200
Subject: The cleanest way to power off a board inside the kernel.
Message-ID: <BANLkTinwsEmyCRVbRBm+grhth9Dx8N+Bfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are some boards out there, including Beagleboard xM, which are
provided with a PMIC that is able to enable or disable power supply
for the system. The interfaces used for that purpose usually include
gpios or I2C.
What is the cleanest way, provided there are some, to tell those
circuits at the end of the power down process to cut off the power
supply of the system?

At first glance I thought there could be a board specific hook for
that purpose but I couldn't find any, just an endless loop "while
(1);" instead.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com

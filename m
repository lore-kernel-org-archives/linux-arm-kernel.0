From: javier.martin@vista-silicon.com (javier Martin)
Date: Mon, 7 Sep 2009 09:09:00 +0200
Subject: Reading MAC address from I2C serial memory.
Message-ID: <eedb5540909070009o4d5d75d1s457d52e06fbf11e3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have an i.mx27 chip with a 24AA02E48 memory connected to i2c-1 port.
This chip contains a unique MAC address.

As I have seen in the fec ethernet driver, it reads MAC addresses from
plain memory depending on the platform it is running. I had planned
copying the MAC address to internal VRAM of the i.mx27 so that fec
could read it from there in the same way as it is done for the other
platforms.

However, this would require that someone would read MAC address from
I2C memory and put it there. Is there a possibility to use early i2c
in board specific code for this purpose? If not, what would be a clean
way of doing this in the kernel?

Thank you.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com

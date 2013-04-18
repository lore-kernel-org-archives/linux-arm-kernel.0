From: marcio@netopen.com.br (Marcio Campos de Lima)
Date: Thu, 18 Apr 2013 10:47:17 -0200
Subject: AT91SAM9M10: Problem porting driver for MT9P031 sensor
In-Reply-To: <2001207140.384354.1366290836027.open-xchange@email.1und1.de>
Message-ID: <CD957E83.AF12%marcio@netopen.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

I am porting the MT9P031 sensor device driver for a custom designed board
based at the AT91SAM9M45-EK development board and Linux 3.6.9.
The driver detects the sensor but does not create /dev/video1. I cannot
even see /dev/video0 that usually is created by default.

Can anybody help me?
Thanks
MArcio

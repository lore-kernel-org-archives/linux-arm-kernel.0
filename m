From: lwalkera@ieee.org (Laine Walker-Avina)
Date: Thu, 4 Nov 2010 15:06:58 -0700
Subject: OMAP not resuming after waking from suspend to RAM after addition of
	the new OMAP serial drivers
Message-ID: <AANLkTikVaBOtwSXHPPYyBHjFOS2yHODRAY7KV5Q3TjTL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm having trouble resuming from RAM suspend with the recent addition
of the new omap-serial driver. It appears to be in some sort of loop
in serial_omap_console_putchar() sometime after console_release_sem()
is called in the resume path. Has this driver been tested going into
and out of suspend?

Thanks,
-- 
Laine Walker-Avina
Firmware Engineer
PASCO scientific

From: john.tobias.ph@gmail.com (John Tobias)
Date: Mon, 13 May 2013 10:56:47 -0700
Subject: Marvel 8797 Wifi module using SDIO 3.0
Message-ID: <CACUGKYN+OGWOsd7kk68i-mj0QdykWjLJ8Hmmi4XWx8kPnbJx7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I have a Wifi module based on 8797 Marvell chipset and it using SDIO
3.0. I am using iMX6 SD board and linux kernel 3.9 stable released
(https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/).
The 8797 module support the 4bit mode and the problem right now, the
SDHCI controller and the said module couldn't communicate to each
other (if using 4bit mode). But, If I force to use the 1bit mode, both
of them can communicate correctly. Also, I force the SDHCI to use ADMA
or SDMA, but there's no effect output.

I would like to know if anyone here solved the problem or an idea how
to deal with it?.

Regards,

John

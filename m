From: b32955@freescale.com (Huang Shijie)
Date: Fri, 29 Jun 2012 18:02:50 +0800
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20461.30991.63507.369439@ipc1.ka-ro>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>	<1340941925-14591-3-git-send-email-shijie8@gmail.com>	<20120629020650.GB28932@S2101-09.ap.freescale.net>	<20120629063329.GE5844@shlinux2.ap.freescale.net>	<20461.30070.771087.830745@ipc1.ka-ro>	<20120629093437.GK5844@shlinux2.ap.freescale.net>
 <20461.30991.63507.369439@ipc1.ka-ro>
Message-ID: <4FED7D4A.5050603@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?06?29? 17:44, Lothar Wa?mann ??:
> Even if it had fewer clocks you would have to change the driver!
If we do not want to change the driver, we could add the extra clocks in 
the device tree node.

The driver will parse out the extra clocks.

In this way, the driver will not be changed in any platform, no matter 
mx28 or mx6q.


Huang Shijie

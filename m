From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 21:37:45 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: preserve
 MII/RMII setting in fec_stop()
In-Reply-To: <20191.17172.493079.722098@ipc1.ka-ro>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <d6f4de9e4cfb393754b42815a2ef1a59c96eab83.1323163127.git.LW@KARO-electronics.de>
 <20111207094146.GG5550@S2100-06.ap.freescale.net>
 <20191.17172.493079.722098@ipc1.ka-ro>
Message-ID: <20111207133744.GR5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 11:42:28AM +0100, Lothar Wa?mann wrote:
> I'm using a TX28 which has the Ethernet PHY connected in RMII
> mode. You should see the problem, if you unplug the ethernet cable on
> a configured link. Without this patch the kernel will not detect when
> the cable is plugged back in.
> 
Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn

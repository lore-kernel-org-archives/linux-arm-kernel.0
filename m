From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 May 2012 23:48:24 +0800
Subject: [alsa-devel] [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add
 sound device imx6q-sabrelite-sgtl5000
In-Reply-To: <20120510114956.GI17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
 <20120510064816.GC17875@S2101-09.ap.freescale.net>
 <20120510093444.GI2982@b20223-02.ap.freescale.net>
 <20120510094113.GG17875@S2101-09.ap.freescale.net>
 <20120510094508.GN3908@opensource.wolfsonmicro.com>
 <20120510114956.GI17875@S2101-09.ap.freescale.net>
Message-ID: <20120510154823.GA18625@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 07:49:58PM +0800, Shawn Guo wrote:
> I did not make myself clear, but you made :)  Yes, this is exactly the
> thing on my mind, and the circuit will look like:
> 
It seems I was just misled by the impression that we should have
a route of MIC_IN <-- Mic Bais.  I just checked through the SGTL5000
data sheet and it does not really mention about this.

Richard,

Will test your route setting and then apply the patch if everything
goes fine.

-- 
Regards,
Shawn

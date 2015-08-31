From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 31 Aug 2015 16:36:17 +0200
Subject: [PATCH 2/3] ARM: mvebu: add DT support for Seagate Personal Cloud
In-Reply-To: <20150831142857.GP30993@kw.sim.vm.gnt>
References: <1440866805-31731-1-git-send-email-simon.guinot@sequanux.org>
 <1440866805-31731-3-git-send-email-simon.guinot@sequanux.org>
 <20150831125926.GL3684@io.lakedaemon.net>
 <20150831142857.GP30993@kw.sim.vm.gnt>
Message-ID: <20150831143617.GC20180@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But the hardware name is used by the stock U-Boot image to build an
> environment variable: target.dtb. This variable holds the name of
> the DTB file to load (armada-370-n090103.dtb for example) from hard
> disk during the boot process. I was hoping I could keep Linux
> mainline naming compatible with the stock U-Boot.

Hi Simon

Could you make the suggestion towards the product managers that future
new products include seagate in the filename? That will greatly
increase the chance of keeping naming compatibility.

	 Andrew

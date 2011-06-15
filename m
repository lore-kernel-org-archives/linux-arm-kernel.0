From: peter.fordham@gmail.com (Peter Fordham)
Date: Wed, 15 Jun 2011 12:37:31 -0700
Subject: [MPCore Watchdog]: Convert from misc_dev to dynamic device node.
In-Reply-To: <BANLkTin2vBCpiEMcLFTEJ1koUmdTQd11eQ@mail.gmail.com>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com>
	<20110614234858.GA15534@gallagher>
	<BANLkTik02nt4ttTTS-3u5R_ZH0W90FADJQ@mail.gmail.com>
	<20110615085820.GH3075@pulham.picochip.com>
	<BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com>
	<20110615190945.GA2518@pulham.picochip.com>
	<BANLkTin2vBCpiEMcLFTEJ1koUmdTQd11eQ@mail.gmail.com>
Message-ID: <BANLkTinwbcYLR3bAPdSNCay4OUWygi3-DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It's a platform device so it's already on the platform bus under:
>
> /sys/devices/platform/mpcore_wdt

sorry, that should have been: /sys/bus/platform/devices/mpcore_wdt.

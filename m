From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Sep 2014 12:49:52 -0700
Subject: [PATCH 0/2] ARM: dts: dra7-evm: fixes for mux and VTT control
In-Reply-To: <1409837008-32144-1-git-send-email-nm@ti.com>
References: <1409837008-32144-1-git-send-email-nm@ti.com>
Message-ID: <20140904194951.GB14698@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140904 06:24]:
> Hi,
> 
> The following series was inspired in part by http://marc.info/?l=linux-omap&m=140974309205295&w=2
> causing me to try and do an audit of pinctrl configurations on the platform.
> 
> Further, failures on latest board updates in the automated farm also
> caused identification of a fix which was yet to be send to upstream
> from product kernel. Slightly unrelated patches in this series.
> 
> So here they are..
> based on v3.17-rc1:
> before-dra7xx-evm:  Boot FAIL: http://paste.ubuntu.org.cn/1477597
> (fails can be at different times though.. random crashes without VTT is usual)..
> after-dra7xx-evm:  Boot PASS: http://paste.ubuntu.org.cn/1477596

Thanks applying both into omap-for-v3.17/fixes-v2.

Regards,

Tony

From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Nov 2013 22:06:51 +0800
Subject: [PATCHv12][ 4/8] pinctrl: pinctrl-imx: add imx25 pinctrl driver
In-Reply-To: <5283538D.8060807@eukrea.com>
References: <1383727939-4190-1-git-send-email-denis@eukrea.com>
 <1383727939-4190-4-git-send-email-denis@eukrea.com>
 <20131107081721.GC6500@S2101-09.ap.freescale.net>
 <5283538D.8060807@eukrea.com>
Message-ID: <20131113140647.GA17819@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 11:25:17AM +0100, Denis Carikli wrote:
> On 11/07/2013 09:17 AM, Shawn Guo wrote:
> >Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Thanks,
> 
> In linux-next's master of 20131113 [1], I saw that this patch made it:
> 7887424 ARM i.MX25: build in pinctrl support.
> 
> However that other patch seems not to be in linux-next's master or
> in your for-next tree:
> cd435c4 pinctrl: pinctrl-imx: add imx25 pinctrl driver

As stated in the message [1], I only applied #5, #6 and #7.  The first 3
should be applied by FB maintainer while #4 should be applied by pinctrl
maintainer.  As the last one patch has some DT bindings introduced in
#2, I cannot apply it until patch #2 gets accepted.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/278078/focus=51080

> 
> References:
> [1] 84ea88b Add linux-next specific files for 20131113
> 
> Denis.

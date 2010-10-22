From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Fri, 22 Oct 2010 12:28:57 +0300
Subject: [patch v2 00/10] efikamx support improvements - try 2
In-Reply-To: <20101021103855.115653951@rtp-net.org>
References: <20101021103855.115653951@rtp-net.org>
Message-ID: <20101022092857.GF17631@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Oct 21, Arnaud Patard wrote:
> 
> Hi,
> 
> This patchset aims at improving current efikamx support. It adds support for :
> - board id detection
> - sdhc
> - leds
> - power button
> - spi nor
> - reset
> 
> I also had to fix/improve some imx51 iomux header so there are patches for
> iomux-mx51.h.
> 
> v2:
> - split iomux patch 3 into 2 patches
> - reorder patches
> - fix space comment
> - fix Amit's comments
> - decrease board id msleep
> 
> Arnaud
> 

Please fix the typo in 07/10 description. Or perhaps Sascha will fix it while committing.

Also Dinh has added mx51_add_buttons() to platform code. 07/10 should be
modified to use that. Search for "ARM: imx: Add gpio-keys to mx51 babbage
board" on LAKML.

After that, for the whole series, you can add,

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

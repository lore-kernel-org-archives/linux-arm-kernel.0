From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Oct 2013 11:49:49 +0800
Subject: eMMC 4.51
In-Reply-To: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
References: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
Message-ID: <20131009034944.GA8861@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 07:00:58PM -0700, John Tobias wrote:
> Hello,
> 
> I am using git://gitorious.org/thierryreding/linux-next.git to boot my
> custom board based on iMX6 sololite. My board has SanDisk iNAND 4.51
> I/F and wifi module (Marvel SD8797). The latest update of
> sdhci-esdhc-imx.c supports DDR50/SDR50/SDR104 and I would like to use
> it for my device.

The latest update on sdhci-esdhc-imx.c only enables the support of UHS SD card in
SDR104 mode.  Neither DDR50 nor eMMC is supported so far.

Shawn

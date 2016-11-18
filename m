From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:43:33 -0800
Subject: [GIT PULL] Qualcomm Device Tree Changes for v4.10
In-Reply-To: <1479017736-13564-5-git-send-email-andy.gross@linaro.org>
References: <1479017736-13564-1-git-send-email-andy.gross@linaro.org>
 <1479017736-13564-5-git-send-email-andy.gross@linaro.org>
Message-ID: <20161118074333.GP1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 13, 2016 at 12:15:35AM -0600, Andy Gross wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-4.10
> 
> for you to fetch changes up to 52a1a5f773110f687c34a828ef42fdb882b6b908:
> 
>   ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard (2016-10-25 08:42:37 -0500)
> 
> ----------------------------------------------------------------
> Qualcomm Device Tree Changes for v4.10
> 
> * Add EBI2 support to MSM8660
> * Add SMSC ethernet support to APQ8060
> * Add support for display, pstore, iommu, and hdmi to APQ8064
> * Add SDHCI node to MSM8974 Hammerhead
> * Add WP8548 MangOH board support (MDM9615)
> 
> ----------------------------------------------------------------
> Archit Taneja (2):
>       arm: dts: qcom: apq8064: Add display DT nodes
>       arm: dts: qcom: apq8064-ifc6410: Add HDMI support
> 
> Bhushan Shah (1):
>       ARM: dts: qcom: msm8974-hammerhead: Add sdhci1 node
> 
> John Stultz (3):
>       arm: dts: qcom: apq8064: Add dsi, gpu and iommu nodes
>       arm: dts: qcom: apq8064-nexus7: Add DSI and panel nodes
>       arm: dts: qcom: apq8064-nexus7: Add pstore support to nexus7
> 
> Linus Walleij (2):
>       ARM: dts: add EBI2 to the Qualcomm MSM8660 DTSI
>       ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard
> 
> Neil Armstrong (5):
>       ARM: dts: Add MDM9615 dtsi
>       dt-bindings: qcom: Add MDM9615 bindings
>       ARM: dts: Add Sierra Wireless WP8548 dtsi
>       ARM: dts: Add WP8548 based MangOH Green board DTS

We tend to keep the SoC manufacturer as the topmost prefix here, to keep
things in common.

While the Sierra Wireless products are modules, they are based on QCOM SoCs.
So the expected names would be qcom-<soc>-module. Something like
qcom-mdm9615-wp8548.dtsi and qcom-mdm9615-wp8548-mangoh-green.dts.

Can you respin with this addressed? Thanks!


-Olof

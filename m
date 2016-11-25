From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Nov 2016 00:29:57 +0100
Subject: [GIT PULL v2] Qualcomm Device Tree Changes for v4.10
In-Reply-To: <1479535031-14817-1-git-send-email-andy.gross@linaro.org>
References: <1479535031-14817-1-git-send-email-andy.gross@linaro.org>
Message-ID: <10048670.JfC4Mf6feL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 18, 2016 11:57:11 PM CET Andy Gross wrote:
> Qualcomm Device Tree Changes for v4.10 - v2
> 
> * Add EBI2 support to MSM8660
> * Add SMSC ethernet support to APQ8060
> * Add support for display, pstore, iommu, and hdmi to APQ8064
> * Add SDHCI node to MSM8974 Hammerhead
> * Add WP8548 MangOH board support (MDM9615)

Thanks for respinning the pull request

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

I see that some of the subject lines are still not what they
should be, as Archit and John both used 'arm' instead of 'ARM'
as the prefix.

It doesn't seem to justify doing a v3 for that, just watch out
for merges in the future. Pulled into next/dt, thanks!

	Arnd

From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 13 Nov 2013 19:16:06 +0800
Subject: [PATCH v2 0/6] mmc: sdhci-esdhc-imx: fix acmd23 unwork and ddr
 not supported on sabresd issues
In-Reply-To: <20131031070442.GD23549@S2101-09.ap.freescale.net>
References: <1383142193-24950-1-git-send-email-b29396@freescale.com>
 <20131031070442.GD23549@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=RxHGw8h4iSDbXsLZDpfiCVzv1x+AoVRVhrQpZx=g1X_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Oct 31, 2013 at 3:04 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Oct 30, 2013 at 10:09:47PM +0800, Dong Aisheng wrote:
>> Dong Aisheng (6):
>>   mmc: sdhci: clear auto cmd setting bits for no data cmds
>>   mmc: sdhci-esdhc-imx: add SDHCI_TRANSFER_MODE read function
>>   ARM: dts: sabresd: add usdhc4 support
>>   mmc: sdhci-esdhc-imx: fix cpas over write issue
>>   mmc: sdhci-esdhc-imx: add MMC_CAP_1_8V_DDR for mx6
>>   mmc: core: mmc DDR mode should not depend on UHS_DDR50
>
> For the series:
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
>

Would you help pick up this series?

Regards
Dong Aisheng

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

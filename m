From: cjb@laptop.org (Chris Ball)
Date: Sun, 20 Oct 2013 22:10:21 -0400
Subject: [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
In-Reply-To: <20131018080922.GC22289@shlinux2.ap.freescale.net> (Dong
 Aisheng's message of "Fri, 18 Oct 2013 16:09:23 +0800")
References: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
 <20131018080922.GC22289@shlinux2.ap.freescale.net>
Message-ID: <87wql78jci.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Oct 18 2013, Dong Aisheng wrote:
> On Thu, Oct 17, 2013 at 03:19:43PM +0800, Shawn Guo wrote:
>> Changes since v1:
>> * Create flags only for features and errata such things, and keep using
>>   is_imx*_esdhc() for small register differences between esdhc variants.
>> 
>> Shawn Guo (4):
>>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
>>   mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
>>   mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
>>   mmc: sdhci-esdhc-imx: create struct esdhc_soc_data
>> 
>>  drivers/mmc/host/sdhci-esdhc-imx.c |  126 +++++++++++++++++++-----------------
>>  1 file changed, 68 insertions(+), 58 deletions(-)
>
> Acked-by: Dong Aisheng <b29396@freescale.com>
>
> I will rebase my mx6sl std tuning patch series based on it
> and send out again.

Thanks, pushed to mmc-next for 3.13 with Dong's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

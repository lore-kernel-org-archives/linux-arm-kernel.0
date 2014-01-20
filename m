From: dongas86@gmail.com (Dong Aisheng)
Date: Mon, 20 Jan 2014 10:42:05 +0800
Subject: [PATCH v2 0/5] mmc: sdhci: a few fixes on timeout and
 max_discard_to
In-Reply-To: <CAA+hA=QgPvTXWbKjpd9e0H3MacGqu8=zz_PpCRAB0NGu_drVtw@mail.gmail.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
 <20131217143025.GX6691@S2101-09.ap.freescale.net>
 <CAA+hA=QgPvTXWbKjpd9e0H3MacGqu8=zz_PpCRAB0NGu_drVtw@mail.gmail.com>
Message-ID: <CAA+hA=Q_p8bLpEA+04cqRhZOCNJQ=i-cgshxQbP8n-fEbu89rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping...

On Mon, Jan 13, 2014 at 6:55 PM, Dong Aisheng <dongas86@gmail.com> wrote:
> Hi Chris,
>
> On Tue, Dec 17, 2013 at 10:30 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Tue, Dec 17, 2013 at 04:16:26PM +0800, Dong Aisheng wrote:
>>> Dong Aisheng (5):
>>>   mmc: sdhci: add platfrom get_max_timeout_count hook
>>>   mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
>>>   mmc: sdhci: add platform set_timeout hook
>>>   mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
>>>   mmc: sdhci: calculate max_discard_to dynamically for
>>>     SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
>>
>> For all,
>>
>> Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
>>
>
> Can you pick this series?
>
> Regards
> Dong Aisheng
>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 8 Oct 2013 21:33:49 -0700
Subject: eMMC 4.51
In-Reply-To: <20131009034944.GA8861@S2101-09.ap.freescale.net>
References: <CACUGKYPDQJPvtXj3NBm8=eYCioWmq=pRVSORNYNZjD13N5ceeg@mail.gmail.com>
 <20131009034944.GA8861@S2101-09.ap.freescale.net>
Message-ID: <CACUGKYP1TXMe5bqAb5Ro5N3ZDQU-QZMiJnOrHuQArxf_am-k2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the info.

Regards,

john

On Tue, Oct 8, 2013 at 8:49 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Oct 08, 2013 at 07:00:58PM -0700, John Tobias wrote:
>> Hello,
>>
>> I am using git://gitorious.org/thierryreding/linux-next.git to boot my
>> custom board based on iMX6 sololite. My board has SanDisk iNAND 4.51
>> I/F and wifi module (Marvel SD8797). The latest update of
>> sdhci-esdhc-imx.c supports DDR50/SDR50/SDR104 and I would like to use
>> it for my device.
>
> The latest update on sdhci-esdhc-imx.c only enables the support of UHS SD card in
> SDR104 mode.  Neither DDR50 nor eMMC is supported so far.
>
> Shawn
>

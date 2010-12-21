From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 21 Dec 2010 18:02:06 +0800
Subject: [PATCH 2/2] ARM i.MX53: Make MX53 EVK bootable
In-Reply-To: <AANLkTinq_kZBC3SDUhuSZCzeqVbqNHJpo3J1HgCcLfQS@mail.gmail.com>
References: <1292902651-26636-1-git-send-email-yong.shen@freescale.com>
	<1292902651-26636-2-git-send-email-yong.shen@freescale.com>
	<AANLkTinq_kZBC3SDUhuSZCzeqVbqNHJpo3J1HgCcLfQS@mail.gmail.com>
Message-ID: <AANLkTikK=NCiuMoMS+QTkQW4xOf5=v1rd-9e7LsVGsyO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Thanks for reminding.

Yong

On Tue, Dec 21, 2010 at 5:26 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Yong,
>
> On Tue, Dec 21, 2010 at 1:37 AM, ?<yong.shen@freescale.com> wrote:
> ...
>> +
>> +static void __init mx53_evk_timer_init(void)
>> +{
>> + ? ? ? mx53_clocks_init(32768, 24000000, 22579200, 24576000);
>> +}
>
> The 24.576MHz clock is not populated on MX53EVK. so this should be:
>
> mx53_clocks_init(32768, 24000000, 22579200, 0);
>
> Regards,
>
> Fabio Estevam
>

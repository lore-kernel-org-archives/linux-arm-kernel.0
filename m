From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 26 Aug 2010 18:01:22 +0800
Subject: [PATCH 1/1] [ARM] pxa: encode IRQ number into .nr_irqs
In-Reply-To: <20100820125432.5cd60d55.ospite@studenti.unina.it>
References: <AANLkTimAgV9USBf4ojoNSuNXL5jogTr0vRy3NfLUyR0_@mail.gmail.com>
	<AANLkTinSumMxHLWt_xp6Kb3ymMkU2d28bZZZFdFM60vd@mail.gmail.com>
	<20100820125432.5cd60d55.ospite@studenti.unina.it>
Message-ID: <AANLkTinf01x1ihsP9d5s6yzq038=Kf2JvOr+02Kig8cG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 6:54 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Fri, 20 Aug 2010 18:42:26 +0800
> Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
>
>> On Fri, Aug 20, 2010 at 6:40 PM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>> > From fabb050a825825b55099766167fa9bb47d4b6941 Mon Sep 17 00:00:00 2001
>> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> > Date: Fri, 20 Aug 2010 15:23:59 +0800
>> > Subject: [PATCH 1/1] [ARM] pxa: encode IRQ number into .nr_irqs
>> >
>> > Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> > ---
>>
>> Changelog:
>>
>> 1. Append .nr_irqs for all 6 EZX platform
>>
>> 2. clean unnecessary PXA_HAVE_BOARD_IRQ in arch/arm/mach-pxa/Kconfig.
>>
>
> The EZX changes look OK now.

Applied to 'devel'.

>
> Thanks,
> ? Antonio
>
> --
> Antonio Ospite
> http://ao2.it
>
> PGP public key ID: 0x4553B001
>
> A: Because it messes up the order in which people normally read text.
> ? See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
>

From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 30 Sep 2010 10:18:12 +0900
Subject: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider in
	host controller
In-Reply-To: <20100917155928.GA7561@void.printf.net>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
	<1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
	<AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
	<20100917155928.GA7561@void.printf.net>
Message-ID: <AANLkTimyvrSxQiF4A4pbmK8nME2ko9MRtqvcuMrY2rKR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 18, 2010 at 12:59 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Thu, Sep 16, 2010 at 06:08:28PM +0900, Kyungmin Park wrote:
>> Well there are two implementations. and no conclusion yet.
>> as s5pc210 don't support internal SDHCI clock, DMC overrides the
>> function operation itself when s5pc210. System LSI use the quirks.
>>
>> Choose any one from MMC maintainer.
>
> Both approaches are generally acceptable for MMC, so I would want to
> leave it up to the maintainer of the driver in question (which is Ben,
> in this case?) to choose between them.

Hi Chris,

Did you get the opinion from Ben?

I hope this decision will be done before 2.6.37 merge windows start to
support SDHCI support on s5pc210.

Thank you,
Kyungmin Park

>
> That said, I think my own mild preference is for Jaehoon's approach.
>
> Thanks,
>
> - Chris.
> --
> Chris Ball ? <cjb@laptop.org> ? <http://printf.net/>
> One Laptop Per Child
>

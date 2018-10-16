From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue, 16 Oct 2018 17:54:46 +0200
Subject: [PATCH 09/11] DT: arm: exynos: add support for thermal trip
 irq-mode
In-Reply-To: <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
References: <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
 <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
 <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
Message-ID: <20181016155448eucas1p26b5aaaf626771b42a2f8c54808391f43~eIc1fLmJw0976609766eucas1p2x@eucas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/16/2018 05:13 PM, Krzysztof Kozlowski wrote:
> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch adds support for new flash which indicates
>> that trip point triggers irq when temperature is met.
>> Exynos5433 supports 8 trip point which will trigger irq.
> 
> Exynos5420? 4 trip point
Thanks, you are right. I will fix the comment in a few places.
> 
> BTW, I just noted that you skipped samsung-soc mailing list.
> 
> DTS patches always should go through arm-soc so in case of Exynos -
> linux-samsung-soc mailing list. The list should be also CC-ed if you
> touch other Exynos or Samsung related code and get_maintainers.pl
> always point it. Because you skipped it, some people might miss your
> patches and definitely Patchwork which I am using won't see them
> (https://patchwork.kernel.org/project/linux-samsung-soc/list/).
OK, I will push v2 through that list also.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 

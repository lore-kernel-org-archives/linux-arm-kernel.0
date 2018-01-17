From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 17 Jan 2018 08:44:01 +0100
Subject: Power domain clock warnings on recent next
In-Reply-To: <f1bf1c15-0bba-4cf6-42a2-80a3982dbae1@samsung.com>
References: <CGME20180116200735epcas4p4455aea99ad21c4c45260d4752d789add@epcas4p4.samsung.com>
 <20180116200728.tjad7tzz3uvsmgg3@kozik-lap>
 <f1bf1c15-0bba-4cf6-42a2-80a3982dbae1@samsung.com>
Message-ID: <CAJKOXPe-xCra5DFh-u2-FvkRwUZyoQbb8P5bK=MHq-9WdnhJWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 7:25 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Krzysztof,
>
> On 2018-01-16 21:07, Krzysztof Kozlowski wrote:
>>
>> Hi everyone,
>>
>> Anyone already noticed or started bisecting warnings coming from
>> clk_core_disable_lock/exynos_pd_power on recent linux-next?
>
>
> Yes, I've noticed it early this week and prepared a patch:
> https://www.spinics.net/lists/arm-kernel/msg628881.html

Thanks!

Best regards,
Krzysztof

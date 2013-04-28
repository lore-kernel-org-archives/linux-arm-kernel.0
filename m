From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 28 Apr 2013 15:52:33 +0900
Subject: [PATCH v3 00/13] ARM: EXYNOS: Fix Universal C210 support
In-Reply-To: <20130427003413.GA2350@quad.lixom.net>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
 <201304251646.28026.arnd@arndb.de> <20130427003413.GA2350@quad.lixom.net>
Message-ID: <517CC731.2050401@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/13 09:34, Olof Johansson wrote:

[...]

>>> On Universal C210 board, both with and without DT:
>>>
>>> Tested-by: Tomasz Figa<t.figa@samsung.com>
>>
>> Reviewed-by: Arnd Bergmann<arnd@arndb.de>
>>
>> Olof, Kgene, I think we should have this one in 3.10 since it fixes
>> a regression. It looks bigger than it really is because I asked Tomasz
>> to do small patches rather than a single combined patch.
>
> Ok. Kukjin, I don't mind collecting this in a late/* branch even though time is
> running late, since it's a regression. Do you want to send it to me or should
> I just pick up the patches?
>
Olof, since too late, would be better if you could pick up this series 
in the late/* branch with my ack:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

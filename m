From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 03 Apr 2014 11:07:34 +0200
Subject: [PATCH 06/10] ARM: EXYNOS: Add support for mapping PMU base
 address via DT
In-Reply-To: <533BFF69.1060701@monstr.eu>
References: <1396425058-4012-1-git-send-email-pankaj.dubey@samsung.com>
 <1396425058-4012-7-git-send-email-pankaj.dubey@samsung.com>
 <533BF905.6070701@samsung.com> <533BFF69.1060701@monstr.eu>
Message-ID: <533D24D6.2030103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/14 14:15, Michal Simek wrote:
>> There were some patches posted for syscon to make it available in earlier
>> system initialization stage: https://lkml.org/lkml/2014/2/19/218
>
> I haven't finished this yet. I have to look at it again.

Thanks for the information, I assume this would be also useful
on the Exynos SoC series, so I'd be happy to see continuation
of those works.

--
Thanks,
Sylwester

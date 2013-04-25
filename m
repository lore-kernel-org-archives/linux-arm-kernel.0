From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 26 Apr 2013 00:48:46 +0900
Subject: [PATCH v3 00/13] ARM: EXYNOS: Fix Universal C210 support
In-Reply-To: <201304251646.28026.arnd@arndb.de>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
 <201304251646.28026.arnd@arndb.de>
Message-ID: <5179505E.8070200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/13 23:46, Arnd Bergmann wrote:

>> On Universal C210 board, both with and without DT:
>>
>> Tested-by: Tomasz Figa<t.figa@samsung.com>
>
> Reviewed-by: Arnd Bergmann<arnd@arndb.de>
>
> Olof, Kgene, I think we should have this one in 3.10 since it fixes
> a regression. It looks bigger than it really is because I asked Tomasz
> to do small patches rather than a single combined patch.
>
Basically, I have no objection, I think, dt for universal_c210 is not 
urgent in v3.10 though, because non-dt will be still supported...

K-Gene

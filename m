From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 Mar 2012 03:00:09 -0700
Subject: linux-next: manual merge of the arm-soc tree with the s5p tree
In-Reply-To: <201203160826.36287.arnd@arndb.de>
References: <20120316174546.5121be30a86c2937579bd3f5@canb.auug.org.au>
 <201203160826.36287.arnd@arndb.de>
Message-ID: <4F630F29.6020101@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/12 01:26, Arnd Bergmann wrote:
> On Friday 16 March 2012, Stephen Rothwell wrote:
>> Today's linux-next merge of the arm-soc tree got a conflict in
>> arch/arm/mach-exynos/common.c between commit 1d7233ac478a ("Merge branch
>> 'next/soc-exynos5250-arch-gpio' into for-next") from the s5p tree and
>> commit 853a0231e057 ("Merge branch 'samsung/soc' into next/soc2") from
>> the arm-soc tree.
>>
>> These merge commits both looks suspect, but I fixed it up as best I could
>> (see below).
>
Thank you, Stehpen.

> Right, both the arm-soc and the s5p tree merge the same commits and
> come to different results. Kgene, please have a look and let me know
> which of the three solutions is correct.
>

Yeah, my resolution is missing and both looks OK to me, actually it's 
just different the position of declaration for 'int ret' and I'm not 
sure which one is better even though I fixed with Arnd's resolution.

Arnd, Stephen, thanks :)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

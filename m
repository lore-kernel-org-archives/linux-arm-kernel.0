From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 10 Apr 2013 00:07:36 +0900
Subject: [PATCH] ARM: EXYNOS: no more support non-DT for EXYNOS SoCs
In-Reply-To: <201304091348.14887.arnd@arndb.de>
References: <2f3001ce3515$9a9ae1b0$cfd0a510$%kim@samsung.com>
 <2f3701ce3516$c29aca80$47d05f80$%kim@samsung.com>
 <201304091348.14887.arnd@arndb.de>
Message-ID: <51642EB8.8050107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/13 20:48, Arnd Bergmann wrote:
> On Tuesday 09 April 2013, Kukjin Kim wrote:
>> One more, as you know, we cannot support all features non-DT did only with
>> DT exynos. But I think, if required, some of them can be kept in samsung
>> tree temporarily.
>
> Which are the features that are going to be missing? Is it possible to
> add the ones that people are likely to miss using auxdata?
>
AFAIK, some of them such as sata, usb phy is on-going and...

>> Note, original patch couldn't submitted to linux arm kernel ml due to size.
>> And please ignore useless line wrapped due to e-mail client problem :-(
>
> You might be able to send it when you create the patch using 'git format-patch
> -M -D', which will leave out deleted files.
>
Thanks, I did as per your suggestion.

- Kukjin

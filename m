From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Tue, 23 Apr 2013 09:32:30 +0530
Subject: [PATCH v3 00/10] ARM: exynos multiplatform series, part 1
In-Reply-To: <201304221512.25920.arnd@arndb.de>
References: <1365716245-99231-1-git-send-email-arnd@arndb.de>
 <201304191536.17796.arnd@arndb.de>
 <CAK9yfHwEZUPs70j3rS7V44RWxpZShEP8uxo3fFW54=L3NG-bDA@mail.gmail.com>
 <201304221512.25920.arnd@arndb.de>
Message-ID: <CAK9yfHxR_NE2R8qzx4p2DinJHqZoOK-4g6EtiAg6fecjy_Vd5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 April 2013 18:42, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 22 April 2013, Sachin Kamat wrote:
>>
>> With this branch now available (merged) in linux-next (20130422),
>> looks like exynos4 DT support is broken on it. Tested on Origen 4210
>> and 4412 and I get the following warnings on 4412 Origen board with
>> exynos_defconfig (Note that clocks are all 0). However, it boots fine
>> on Arndale board.
>
> I think this issue should be fixed with the patch that Thomas Abraham
> just sent. Thomas, can you confirm?

Boot tested Origen 4210, 4412 and Arndale boards after applying Thomas
Abraham's chip-id dt support patches.
They all boot fine.

However I could not see multiplatform support for Exynos in
exynos_defconfig (i.e., CONFIG_ARCH_EXYNOS and
CONFIG_ARCH_MULTIPLATFORM are not set together). This was available in
your 'samsung/exynos-multiplatform' branch. Has this been disabled in
next?

---
With warm regards,
Sachin

From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 4 May 2015 08:57:46 -0700
Subject: [PATCH 1/1] ARM: dts: Make DP a consumer of DISP1 power domain on
 Exynos5420
In-Reply-To: <126501d082dd$af818a30$0e849e90$@kernel.org>
References: <1428870659-5525-1-git-send-email-javier.martinez@collabora.co.uk>
 <552F6750.6020306@collabora.co.uk>
 <55417810.6070202@collabora.co.uk>
 <126501d082dd$af818a30$0e849e90$@kernel.org>
Message-ID: <CAMAWPa85HcQ66eqg-WaoVqVm+vByTQXZ69jZCmhsaGqLjfKFxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Wed, Apr 29, 2015 at 5:36 PM, Kukjin Kim <kgene@kernel.org> wrote:

[...]

>>
>> Could you please apply $subject to fix the imprecise external abort issue.
>>
> Sure I'll in this weekend.

This patch is still not in linux-next.

Also I think this fix is needed as a fix for mainline v4.1-rc as well,
where the same is happening.

Krzysztof has generously offered to help collecting/queuing/submitting
patches to help improve the maintenance of exynos.  Please work
closely with him share the responsibility of improving the state of
mainline exynos support.

Thanks,

Kevin

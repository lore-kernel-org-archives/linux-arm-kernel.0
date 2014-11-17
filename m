From: k.kozlowski@samsung.com (=?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?=)
Date: Mon, 17 Nov 2014 17:57:29 +0100
Subject: exynos boot falures in linux-next
In-Reply-To: <7hoas54y7k.fsf@deeprootsystems.com>
References: <E1XqKYI-0000pQ-4b@ip-10-35-177-41.ec2.internal>
 <7hoas54y7k.fsf@deeprootsystems.com>
Message-ID: <546A28F9.9080402@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.11.2014 16:57, Kevin Hilman wrote:
> FYI...
> 
> Various new exynos5 boot failures starting next-20141117.  Looking in
> the boot logs, the boot stops during DRM initialization.
> 
> Note that the boot failures are only on exynos_defconfig, and not
> multi_v7_defconfig.

Cc: +Inki Dae, +dri-devel

This came up on Trats2 board (Exynos 4412) since next-20141105:
https://lkml.org/lkml/2014/11/6/125

Disabling DRM helps.

Best regards,
Krzysztof

> 
> Excerpt from boot report below, or recent exynos boots can also be
> explored here:
> 
>    http://status.armcloud.us/boot/?exynos
> 
> Kevin
> 
> 
> Kevin's boot bot <khilman@kernel.org> writes:
> 
>> Full Build report: http://status.armcloud.us/build/next/kernel/next-20141117/
>> Full Boot report:  http://status.armcloud.us/boot/all/job/next/kernel/next-20141117/
>>
>> Tree/Branch: next
>> Git describe: next-20141117
>>
>> Failed boot tests
>> =================
> 
> [...]
> 
>>            exynos5422-odroid-xu3:     FAIL:    arm-exynos_defconfig
>>                                       http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-exynos_defconfig/boot-exynos5422-odroid-xu3.html
>>               exynos5250-arndale:     FAIL:    arm-exynos_defconfig
>>                                       http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-exynos_defconfig/boot-exynos5250-arndale.html
>>              exynos5800-peach-pi:     FAIL:    arm-exynos_defconfig
>>                                       http://storage.armcloud.us/kernel-ci/next/next-20141117/arm-exynos_defconfig/boot-exynos5800-peach-pi.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

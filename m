From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 01 Apr 2014 13:22:34 +0200
Subject: exynos4: cpu hotplug + cpuidle/AFTR broken
In-Reply-To: <533A9849.1080402@linaro.org>
References: <533A9849.1080402@linaro.org>
Message-ID: <533AA17A.1090405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 01.04.2014 12:43, Daniel Lezcano wrote:
>
> Hi all,
>
> I tried the v3.14 kernel and unplugged the cpu1. That leads to a kernel
> hang without any trace.
>
> If I disable the cpuidle AFTR state through sysfs before unplugging
> cpu1, it works well.
>
> I reproduced the issue on v3.14, v3.13, v3.12, v3.11
>
> v3.10 works fine.

Could you try to reproduce the same issue on linux-next? Some of PM 
issues on Exynos should be patches there.

Best regards,
Tomasz

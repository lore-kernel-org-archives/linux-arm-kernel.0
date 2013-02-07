From: inderpal.singh@linaro.org (Inderpal Singh)
Date: Thu, 7 Feb 2013 16:58:34 +0530
Subject: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
In-Reply-To: <CAOh2x=n+-PenMYNf9iZG0SeS4ENYdh0aKFWVZtLqWVHDUYhaMw@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
 <1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
 <CAG17yqSh3bk8C9YSXtEsh4F5AJttwbVjFY0tdoy6=SZX5qibkQ@mail.gmail.com>
 <CAOh2x=n+-PenMYNf9iZG0SeS4ENYdh0aKFWVZtLqWVHDUYhaMw@mail.gmail.com>
Message-ID: <CAG17yqQtvg4aL7tV6b5GmrdhjwvT4k+iCyStRykkHFOmP21Q9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 February 2013 16:49, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Thu, Feb 7, 2013 at 10:39 AM, Inderpal Singh
> <inderpal.singh@linaro.org> wrote:
>>> +#define DRIVER_NAME            "exynos5440_dvfs"
>
>>> +static struct cpufreq_driver exynos_driver = {
>>> +       .name           = DRIVER_NAME,
>>> +};
>>> +
>>
>> Since this driver is only for exynos5440, having the same names as
>> common exynos-cpufreq is misleading.
>
> Where is it same?

I meant hooks names (verify/get/target and init)

Thanks,
Inder

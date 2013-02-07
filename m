From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 7 Feb 2013 16:49:44 +0530
Subject: [PATCH 2/3] cpufreq: exynos: Adding cpufreq driver for exynos5440
In-Reply-To: <CAG17yqSh3bk8C9YSXtEsh4F5AJttwbVjFY0tdoy6=SZX5qibkQ@mail.gmail.com>
References: <1360179562-19950-1-git-send-email-amit.daniel@samsung.com>
 <1360179562-19950-2-git-send-email-amit.daniel@samsung.com>
 <CAG17yqSh3bk8C9YSXtEsh4F5AJttwbVjFY0tdoy6=SZX5qibkQ@mail.gmail.com>
Message-ID: <CAOh2x=n+-PenMYNf9iZG0SeS4ENYdh0aKFWVZtLqWVHDUYhaMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 10:39 AM, Inderpal Singh
<inderpal.singh@linaro.org> wrote:
>> +#define DRIVER_NAME            "exynos5440_dvfs"

>> +static struct cpufreq_driver exynos_driver = {
>> +       .name           = DRIVER_NAME,
>> +};
>> +
>
> Since this driver is only for exynos5440, having the same names as
> common exynos-cpufreq is misleading.

Where is it same?

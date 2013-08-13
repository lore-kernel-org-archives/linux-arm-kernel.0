From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 13 Aug 2013 19:16:00 +0530
Subject: [PATCH V2 00/35] CPUFreq: Implement light weight ->target(): for
 3.13
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Message-ID: <CAKohpo=-PWt23aLiVW3MxU6gZ-_Db=QKYaaKO-f+e+u8hirpJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2013 19:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Currently prototype of cpufreq_drivers target routines is:
>
> int target(struct cpufreq_policy *policy, unsigned int target_freq,
>         unsigned int relation);
>
> And most of the drivers call cpufreq_frequency_table_target() to get a valid
> index of their frequency table which is closest to the target_freq. And they
> don't use target_freq and relation after it.

I just came to know from a friend that I have written "covert" instead of
"convert" in subjects of all the patches.

Will fix it in my repo for now.

Thanks Sudeep :)

--
viresh

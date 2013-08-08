From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Aug 2013 14:03:54 +0530
Subject: [PATCH 0/6] Tegra: Use cpufreq-cpu0 driver
In-Reply-To: <CANg6MZgqxF1GBOhtebZLuHBh_F6CxWT=YRsQunPR+wdCQRunPw@mail.gmail.com>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <CANg6MZgqxF1GBOhtebZLuHBh_F6CxWT=YRsQunPR+wdCQRunPw@mail.gmail.com>
Message-ID: <CAKohpo=j1hCsMKgrtR0xkL3hZ3a5gi6tv_yDH7sg6790QNo-Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2013 14:01, Richard Zhao <linuxzsc@gmail.com> wrote:
> On Wed, Aug 7, 2013 at 10:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Hi Stephen,
>>
>> This is the first attempt to get rid of tegra-cpufreq driver. This patchset
>> tries to add supporting infrastructure for tegra to use cpufreq-cpu0 driver.
>
> If tegra has only 4-core fast cpu, I would agree with the patch set. But now
> I'm not so sure. Tegra cpuquiet driver and cluster switch may need special
> settings of cpufreq driver.

I am not familiar with the latest happenings.. This change should be good
enough for not breaking anything that is working with current tegra cpufreq
driver.. If there is a new SoC with different needs then we can talk about it
separately.. As that might not be able to use tegra-cpufreq driver anyway..

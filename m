From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 8 Aug 2013 16:31:22 +0800
Subject: [PATCH 0/6] Tegra: Use cpufreq-cpu0 driver
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Message-ID: <CANg6MZgqxF1GBOhtebZLuHBh_F6CxWT=YRsQunPR+wdCQRunPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 7, 2013 at 10:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Stephen,
>
> This is the first attempt to get rid of tegra-cpufreq driver. This patchset
> tries to add supporting infrastructure for tegra to use cpufreq-cpu0 driver.

If tegra has only 4-core fast cpu, I would agree with the patch set. But now
I'm not so sure. Tegra cpuquiet driver and cluster switch may need special
settings of cpufreq driver.

Thanks
Richard

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 30 Sep 2014 10:48:48 +0530
Subject: [GIT PULL 2/2] ARM: rockchip: cpufreq-cpu0 device
In-Reply-To: <201717175.L17Ccvmpek@phil>
References: <7172632.O1FfdvXn6k@phil>
	<201717175.L17Ccvmpek@phil>
Message-ID: <CAOh2x=nJvtryNgEa6Jx1JMdNa-xW4KQVvrk7epXvdN6hPDbXLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 3:13 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi Arnd, Olof,
>
> this one patch adds a platform-device for cpufreq-cpu0 to mach-rockchip,
> enabling frequency scaling using this cpufreq driver.
>
> While it could be small enough to simply be included in the dt branch,
> I didn't want to take that decision on my own :-)
>
> So please pull
>
>
> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
>
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v3.18-rockchip-cpufreqdev
>
> for you to fetch changes up to 47b06fc2d97a0d98d6053357561f2953d6547d25:
>
>   ARM: rockchip: add a cpufreq-cpu0 device (2014-09-29 09:21:38 +0200)
>
> ----------------------------------------------------------------
> Add a simple cpufreq-cpu0 device for mach-rockchip
>
> ----------------------------------------------------------------
> Heiko Stuebner (1):
>       ARM: rockchip: add a cpufreq-cpu0 device

cpufreq-cpu0 is recently renamed to cpufreq-dt just in case you missed that.

From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Aug 2013 10:23:21 +0530
Subject: [PATCH] cpufreq: tegra: fix the wrong clock name
In-Reply-To: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
References: <1377222238-9439-1-git-send-email-josephl@nvidia.com>
Message-ID: <CAKohpoki3wG=S8AU4v2LTk7NTLNS+BU_Yz5O+LTQTcdehciUbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 August 2013 07:13, Joseph Lo <josephl@nvidia.com> wrote:
> The "cpu" and "pclk_p_cclk" was a virtual clock name that was used in
> the legacy Tegra clock framework. It was not used after converting to
> CCF. Fix it as the correct clock name that we are using.
>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>  drivers/cpufreq/tegra-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to cpufreq-fixes. Thanks.

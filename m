From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 9 Mar 2018 15:30:26 +0530
Subject: [PATCH 00/27] cpufreq: Stop validating cpufreq table in drivers
In-Reply-To: <cover.1519620578.git.viresh.kumar@linaro.org>
References: <cover.1519620578.git.viresh.kumar@linaro.org>
Message-ID: <20180309100026.GQ6842@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26-02-18, 10:38, Viresh Kumar wrote:
> Hi,
> 
> A patchset [1] sent last week already updated the cpufreq core to start
> validating cpufreq table if the policy contains a valid
> "policy->freq_table" pointer.
> 
> This series updates all such drivers to stop validating the cpufreq
> table directly and let only the core handle it.
> 
> It depends on the previous series [1] and two cleanup patches [2][3] and
> is rebased over 4.16-rc3.
> 
> It is already tested by the 0-day testing infrastructure and no issues
> were reported.

We will assume no objections or concerns if you (cc'd here and on the individual
commits) don't respond and the series will then get merged into linux-next next
week.

Thanks.

--
viresh

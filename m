From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 07 Aug 2013 11:43:33 -0600
Subject: [PATCH 3/6] ARM: Tegra: Enable OPP library
In-Reply-To: <bfa34bd91e0fa4c6e215517e10c93ab271486418.1375886595.git.viresh.kumar@linaro.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <bfa34bd91e0fa4c6e215517e10c93ab271486418.1375886595.git.viresh.kumar@linaro.org>
Message-ID: <52028745.6080707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2013 08:46 AM, Viresh Kumar wrote:
> cpufreq-cpu0 driver is dependent on OPP library and hence we need to enable it
> for Tegra as we are going to use cpufreq-cpu0.

Shouldn't these be selected by something in drivers/cpufreq/Kconfig?

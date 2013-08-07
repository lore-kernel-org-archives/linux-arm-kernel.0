From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Aug 2013 23:38:03 +0530
Subject: [PATCH 3/6] ARM: Tegra: Enable OPP library
In-Reply-To: <52028745.6080707@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
 <bfa34bd91e0fa4c6e215517e10c93ab271486418.1375886595.git.viresh.kumar@linaro.org>
 <52028745.6080707@wwwdotorg.org>
Message-ID: <CAKohponrGLbx11f7rvamxaSme2XhgPuMDuOOmVgsmhMsTtN2Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2013 23:13, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/07/2013 08:46 AM, Viresh Kumar wrote:
>> cpufreq-cpu0 driver is dependent on OPP library and hence we need to enable it
>> for Tegra as we are going to use cpufreq-cpu0.
>
> Shouldn't these be selected by something in drivers/cpufreq/Kconfig?

There is nothing tegra specific in that directory now and so probably
this is the best place :)

Creating a config option only for this doesn't sound great to me..

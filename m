From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 30 Mar 2015 11:04:08 +0530
Subject: [PATCH v3] cpufreq: hisilicon: add acpu driver
In-Reply-To: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
References: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CAKohpomCQos+a8rjZa=B=jmhffi-qWrjz_nSZ_i68fxnJ5ioVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 March 2015 at 10:56, Leo Yan <leo.yan@linaro.org> wrote:
> Add acpu driver for hisilicon SoC, acpu is application processor
> subsystem. Currently the acpu has the coupled clock domain for two
> clusters, so this driver will directly use cpufreq-dt driver as
> backend.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm         |  9 ++++++++
>  drivers/cpufreq/Makefile            |  1 +
>  drivers/cpufreq/hisi-acpu-cpufreq.c | 42 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

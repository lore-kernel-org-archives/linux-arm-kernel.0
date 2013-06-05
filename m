From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 5 Jun 2013 11:20:13 +0530
Subject: [PATCH] cpufreq: kirkwood: Select CPU_FREQ_TABLE option
In-Reply-To: <1370365398-484-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370365398-484-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CAOh2x=mUM5t1b=DvnTJVHY-c7YZ9wLRAqSCpwLb13HbL7ha2OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 10:33 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> We need to select CPU_FREQ_TABLE in order to build without
> this kind of errors:
>
> drivers/built-in.o: In function `kirkwood_cpufreq_cpu_exit':
> /home/zeta/linux-devel/marvell-legacy/drivers/cpufreq/kirkwood-cpufreq.c:145:
> undefined reference to `cpufreq_frequency_table_put_attr'
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)

Check Maintainers to see list of people and lists you need to cc
for cpufreq stuff.

Anyway, Applied to cpufreq-next now.

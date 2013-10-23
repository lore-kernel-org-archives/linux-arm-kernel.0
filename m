From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 23 Oct 2013 10:19:06 +0530
Subject: [PATCH 2/2] cpufreq: arm_big_little: reconfigure switcher
 behavior at run time
In-Reply-To: <1382500691-634-3-git-send-email-nicolas.pitre@linaro.org>
References: <1382500691-634-1-git-send-email-nicolas.pitre@linaro.org>
 <1382500691-634-3-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAKohpo=-nxsqJuo7RTf8q-P5caTSuNqFWjX6ncf+GmQvL1-Q9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 October 2013 09:28, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> The b.L switcher can be turned on/off at run time.  It is therefore
> necessary to change the cpufreq driver behavior accordingly.
>
> The driver must be unregistered/registered with the cpufreq core
> to reconfigure freq tables for the virtual or actual CPUs. This is
> accomplished via the b.L switcher notifier callback.
>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Got really confused on what should I reply with,
Ack/Tested/Reviewed/Signed-off :)

Because we have worked closely on these patches, maybe
this suits best :)

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

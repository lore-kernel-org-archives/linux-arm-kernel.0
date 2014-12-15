From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 15 Dec 2014 10:50:37 -0800
Subject: [PATCH] ARM: defconfigs: use CONFIG_CPUFREQ_DT
In-Reply-To: <2757282.fj6z18fAYb@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Mon, 15 Dec 2014 16:00:12 +0100")
References: <63217079d4b61d835fed98198ae1e3f0e6329de1.1418617005.git.viresh.kumar@linaro.org>
 <2757282.fj6z18fAYb@vostro.rjw.lan>
Message-ID: <7h1to0iw76.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> On Monday, December 15, 2014 09:48:19 AM Viresh Kumar wrote:
>> CONFIG_GENERIC_CPUFREQ_CPU0 disappeared with commit bbcf071969b20f
>> ("cpufreq: cpu0: rename driver and internals to 'cpufreq_dt'") and some
>> defconfigs are still using it instead of the new one.
>> 
>> Use the renamed CONFIG_CPUFREQ_DT generic driver.
>> 
>> Cc: <stable@vger.kernel.org>        # 3.18
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> OK, so who should be applying this?
>

Normally, we take these defconfig changes through the arm-soc tree, and
I think that should continue, otherwise we'll be bound to have conflicts.

Note all the pull requests for this merge window are already sent, but
I'll queue this up in arm-soc/fixes so it can make it during the
v3.19-rc cycle.

Thanks,

Kevin

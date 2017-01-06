From: markus.mayer@broadcom.com (Markus Mayer)
Date: Fri, 6 Jan 2017 10:26:15 -0800
Subject: [PATCH v4 2/2] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
In-Reply-To: <20170106041442.GD21926@vireshk-i7>
References: <20161220225530.96699-1-code@mmayer.net>
 <20161220225530.96699-3-code@mmayer.net>
 <20170106041442.GD21926@vireshk-i7>
Message-ID: <CAGt4E5tALVrQSrib+h3BN=A6umnA4JgWAeUfJew02tGS1kAjdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2017 at 20:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 20-12-16, 14:55, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> This CPUfreq driver provides basic frequency scaling for older Broadcom
>> STB SoCs that do not use AVS firmware with DVFS support. There is no
>> support for voltage scaling.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
>>  drivers/cpufreq/Kconfig.arm       |  12 ++
>>  drivers/cpufreq/Makefile          |   1 +
>>  drivers/cpufreq/brcmstb-cpufreq.c | 377 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 390 insertions(+)
>>  create mode 100644 drivers/cpufreq/brcmstb-cpufreq.c
>
> I am fine with this patch as I have already Acked V3 of it. But please fix the
> bindings improvement suggested by Stephen first.

Yes, that is on my list of things to do. I will send an update
hopefully next week.

Thanks,
-Markus

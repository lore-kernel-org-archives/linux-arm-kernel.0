From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 Apr 2013 10:24:38 +0530
Subject: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
In-Reply-To: <CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <927100d30bf40d4fec477cc7d8d464669a22d167.1365079581.git.viresh.kumar@linaro.org>
 <2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
 <CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
Message-ID: <CAKohpomgqWi9jfpqtW8cxu7BeJQCEySqbdDNVK=4Fh1ji1FyMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 April 2013 12:36, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 5 April 2013 12:18, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Basically, this moving looks good to me, but should be re-worked based on
>> for-next of samsung tree because this touches too many samsung stuff so this
>> should be sent to upstream via samsung tree.
>
> Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> it can't be
> moved to your tree if there is a issue.
>
> What tree/branch? I used:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next
>
>> Applying: cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
>> error: patch failed: arch/arm/Kconfig:2166
>> error: arch/arm/Kconfig: patch does not apply
>
> above two are obvious as you haven't applied other patches in this series.
>
>> error: patch failed: arch/arm/mach-s3c24xx/Kconfig:28
>> error: arch/arm/mach-s3c24xx/Kconfig: patch does not apply
>> error: patch failed: arch/arm/mach-s3c24xx/Makefile:17
>> error: arch/arm/mach-s3c24xx/Makefile: patch does not apply
>> error: patch failed: drivers/cpufreq/Makefile:63
>> error: drivers/cpufreq/Makefile: patch does not apply
>
> Same here.
>
>> error: drivers/cpufreq/s3c2412-cpufreq.c: does not exist in index
>
> I can still see it in for-next.
>
> Attached is my patch based of your for-next

Kukjin,

As Rafael has already dropped it, can you apply it at your end and make sure
it doesn't miss the merge cycle?

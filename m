From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 07 Jun 2013 13:31:24 +0200
Subject: [GIT PULL RESENT] CPUFreq: ARM Updates for v3.11
In-Reply-To: <CAKohpokJt=8UpAKKEEFaojq-M_GPawrDRBdXL8erEDe2jh=Q4A@mail.gmail.com>
References: <CAKohpokJt=8UpAKKEEFaojq-M_GPawrDRBdXL8erEDe2jh=Q4A@mail.gmail.com>
Message-ID: <195814068.OMscJ0xp3P@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 07, 2013 04:39:49 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> 
>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/vireshk/linux.git cpufreq-next
> 
> for you to fetch changes up to ea61623fe9badd5a195b3a0878e6d89a2f97ac0e:
> 
>   cpufreq: kirkwood: Select CPU_FREQ_TABLE option (2013-06-07 16:33:36 +0530)

Pulled, thanks Viresh!

Rafael


> ----------------------------------------------------------------
> Arnd Bergmann (2):
>       cpufreq: SPEAr needs cpufreq table
>       cpufreq: big.LITTLE needs cpufreq table
> 
> Ezequiel Garcia (1):
>       cpufreq: kirkwood: Select CPU_FREQ_TABLE option
> 
>  drivers/cpufreq/Kconfig.arm | 3 +++
>  1 file changed, 3 insertions(+)
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

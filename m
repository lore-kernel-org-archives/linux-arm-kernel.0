From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 12 Nov 2012 15:04:21 +0100
Subject: [GIT PULL v4] Renesas ARM-based SoC for v3.8
In-Reply-To: <20121106143202.GF27284@quad.lixom.net>
References: <1352177853-6008-1-git-send-email-horms@verge.net.au>
 <20121106143202.GF27284@quad.lixom.net>
Message-ID: <CABYn4sy_EaF5Ywhwj_-Ahc_8R5gtnu0RZPwQFFc7vBvRdBnOXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

unfortunately 3 patches contributed by me are "evil" and need to removed.

Bastian Hecht (4):
      ARM: shmobile: emev2: Replace modify_scu_cpu_psr with scu_power_mode
      ARM: shmobile: sh73a0: Replace modify_scu_cpu_psr with scu_power_mode
      ARM: shmobile: r8a7779: Replace modify_scu_cpu_psr with scu_power_mode
...

The code changes the flags of the wrong cpus - which breaks the whole
bootup of secondary CPUs. So please drop these patches!
Sorry for being too careless in this sensitive area - I'll do better.

Thanks,

 Bastian



2012/11/6 Olof Johansson <olof@lixom.net>:
> On Tue, Nov 06, 2012 at 01:57:22PM +0900, Simon Horman wrote:
>> Hi Olof, Hi Arnd,
>>
>> please consider the following SoC enhancements for 3.8.
>>
>> Change since v3:
>> * Remove noise from "ARM: shmobile: Remove SH7367 support"
>>
>> ----------------------------------------------------------------
>> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
>>
>>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc
>
> Pulled, thanks!
>
>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

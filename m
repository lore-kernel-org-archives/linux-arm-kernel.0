From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 10 May 2016 10:28:47 +0200
Subject: [PATCH] firmware/drivers/psci: Fix unused functions when
 CONFIG_CPU_IDLE=n
In-Reply-To: <20160510082250.GA14662@red-moon>
References: <1462864729-11793-1-git-send-email-daniel.lezcano@linaro.org>
 <20160510082250.GA14662@red-moon>
Message-ID: <57319BBF.7060306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 10:22 AM, Lorenzo Pieralisi wrote:
> On Tue, May 10, 2016 at 09:18:49AM +0200, Daniel Lezcano wrote:
>> On the ARM64 architecture, when CPUIDLE is not set in the configuration,
>> the compilation raises a couple of warnings:
>>
>> drivers/firmware/psci.c:70:12: warning: 'psci_pd_power_off' defined but not used [-Wunused-function]
>> drivers/firmware/psci.c:273:12: warning: 'psci_set_suspend_mode_osi' defined but not used [-Wunused-function]
>
> That's not mainline code :)

Ha ha ! Sounds like my scripts are not yet ready :)

Sorry for the noise.

   -- Daniel

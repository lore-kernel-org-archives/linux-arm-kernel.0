From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 15 Sep 2013 19:32:34 +0200
Subject: [PATCH v2] drivers: cpuidle: rename ARM big.LITTLE driver config
 and makefile entries
In-Reply-To: <878uz0e82x.fsf@linaro.org>
References: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com>
 <878uz0e82x.fsf@linaro.org>
Message-ID: <5235EF32.7050302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 11:16 PM, Kevin Hilman wrote:
> Daniel,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
>> Following the reorganization of CPU idle drivers configurations into an ARM
>> specific Kconfig, the existing idle drivers Kconfig entries were renamed and
>> moved to the Kconfig.arm file. Makefile entries were updated accordingly.
>>
>> This patch renames the entries in Kconfig.arm and makefile to make the newly
>> added big.LITTLE CPUidle driver compliant with the new naming convention.
>>
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> We picked up this driver originally through arm-soc (with your signoff)
> because of arch/arm dependencies, but you might as well take this one
> directly since it's isolated to drivers/cpuidle.
> 
> Can you queue this up for v3.12-rc please?

Yes, sure.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

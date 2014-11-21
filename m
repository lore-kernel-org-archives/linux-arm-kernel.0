From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 21 Nov 2014 17:13:45 +0100
Subject: [GIT PULL] cpuidle: A few improvements for ARM cpuidle via DT
In-Reply-To: <17509116.2bjC4d8bef@vostro.rjw.lan>
References: <546C6DEB.8060204@linaro.org> <17509116.2bjC4d8bef@vostro.rjw.lan>
Message-ID: <546F64B9.8060300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 04:56 PM, Rafael J. Wysocki wrote:
> On Wednesday, November 19, 2014 11:16:11 AM Daniel Lezcano wrote:
>>
>> Hi Rafael,
>>
>> this pull request, based on 3.18-rc5, contains a set of changes from
>> Lorenzo Pieralisi.
>>
>>    * Added a 'status' definition flag in the DT to specify the
>> unsupported firmware idle states and ignore those states in the parsing
>> code when initializing the cpuidle driver
>>
>>    * Added an idle state description in the DT. As the idle states are
>> not standardized on ARM, the description gives information about the
>> idle state
>>
>>    * Removed duplicate error message in the arm64 cpuidle drivers
>>
>> Thanks !
>>
>>     -- Daniel
>>
>>
>> The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:
>>
>>     Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)
>>
>> are available in the git repository at:
>>
>>     http://git.linaro.org/git-ro/people/daniel.lezcano/linux.git cpuidle/3.19
>>
>> for you to fetch changes up to 18f95a3640dbf421ab9532e517070a0c1cd4d582:
>>
>>     drivers: cpuidle: Remove cpuidle-arm64 duplicate error messages
>> (2014-11-19 10:16:28 +0100)
>
> Pulled, but I had a conflict with one patch from you I'd already queued up for
> 3.19-rc1.
>
> Can you please have a look at my bleeding-edge branch and check if I resolved
> the conflict correctly?

Hi Rafael,

yes the conflict is correctly resolved.

Thanks
   -- Daniel



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

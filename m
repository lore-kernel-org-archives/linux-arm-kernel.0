From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 03 May 2012 22:29:00 +0200
Subject: [PATCH 11/18][V3] ARM: OMAP3: cpuidle - remove the 'valid' field
In-Reply-To: <87r4v1kofi.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <1335276339-11135-12-git-send-email-daniel.lezcano@linaro.org>
 <87r4v1kofi.fsf@ti.com>
Message-ID: <4FA2EA8C.90207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2012 10:19 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> With the previous changes all the states are valid, except
>> the last state which can be handled by decreasing the number
>> of states.
> I don't think this changelog is valid anymore as you're not doing
> anything to decrease the number of states.
>
> I updated the changelog locally to this:
>
> ARM: OMAP3: cpuidle - remove the 'valid' field
>
> With the previous changes all the states are valid, except the last
> state which is now handled at runtime by next_valid_state() based on
> the errata flags.
>
> Any problems with that?

No problem :)

Thanks for fixing the Changelog.

-- Daniel

-- 
  <http://www.linaro.org/>  Linaro.org ? Open source software for ARM SoCs

Follow Linaro:<http://www.facebook.com/pages/Linaro>  Facebook |
<http://twitter.com/#!/linaroorg>  Twitter |
<http://www.linaro.org/linaro-blog/>  Blog

From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 18 Nov 2013 09:37:49 +0530
Subject: [RFC v2 0/4] Add basic support for ASV
In-Reply-To: <CAJ0PZbS8FxRA_sPTOnWbZcNfUMp=k5Jf_tZHLg1fh6gsAGJ=Gw@mail.gmail.com>
References: <1384515691-26299-1-git-send-email-sachin.kamat@linaro.org>
 <CAJ0PZbS8FxRA_sPTOnWbZcNfUMp=k5Jf_tZHLg1fh6gsAGJ=Gw@mail.gmail.com>
Message-ID: <CAK9yfHzUAnBMB2Bp+eKzR3NH1iRguJn4K45gss5psWzG4Lc7tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi MyungJoo,

On 18 November 2013 08:07, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>
> 2013. 11. 15. ?? 8:44? "Sachin Kamat" <sachin.kamat@linaro.org>?? ??:
>
>
>>
>> Original cover letter from Yadwinder:
>> This series is to add basic common infrastructure for ASV.
>>  Basically ASV is a technique used on samsung SoCs, which provides the
>> recommended supply voltage for dvfs of arm, mif etc. For a given operating
>> frequency, the voltage is recommended based on SoC's ASV group.
>> ASV group gets fussed on SoCs during process of mass production.
>>
>> This series includes:
>>  - basic common infrastructue for ASV. It provides common APIs for user
>> drivers
>> like cpufreq & devfreq and and an interface for SoC specific drivers to
>> register ASV members(instances)
>>  - a common platform driver to register ASV members for exynos SoCs
>>  - an example providing minimal support (only for ARM ASV) for exynos5250
>> chips
>>
>> Its just basic skelton which I wanted to get it reviewed or discussed in
>> early stage, before going ahead on further development based on it.
>>  Presently example is based on static ASV table provided in SoC specific
>> file,
>> which I expects to go into DT. But exactly how and where needs to be
>> discussed,
>> may be in next revisions once we get through the basic skelton.
>>  Also the location of driver in kernel may also seem odd to someone and
>> many more things :).
>>
>> Looking for your valuable reviews and suggestions.
>
> Hi,
>
> As I have commented on the previous thread of Yadwinder, please share the
> directory woth AVS, which is conceptually a superset of ASV.
>
> Ultimately, it would be best if you can supply an infra that can be shared
> with the current AVS, which does not have any currently.
>

Yadwinder has already replied to your suggestion about his concerns. Please
share your comments.

-- 
With warm regards,
Sachin

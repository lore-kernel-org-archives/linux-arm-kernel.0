From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 17 Jul 2013 14:13:58 +0200
Subject: [PATCH v8] ARM: clocksource: add support for MOXA ART SoCs
In-Reply-To: <CACmBeS129VOmFjnF+-iRH1viS+zpoaNMYMaWZ_UiPVxa6ncYeQ@mail.gmail.com>
References: <1373024773-24574-1-git-send-email-jonas.jensen@gmail.com>
 <1373985880-23469-1-git-send-email-jonas.jensen@gmail.com>
 <51E56043.1010509@linaro.org>
 <CACmBeS129VOmFjnF+-iRH1viS+zpoaNMYMaWZ_UiPVxa6ncYeQ@mail.gmail.com>
Message-ID: <51E68A86.3020703@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 10:14 AM, Jonas Jensen wrote:
> On 16 July 2013 17:01, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> 1. could you elaborate the patch log: as it is a new driver, a nice
>> description of the timer hardware would be valuable for people willing
>> to understand the code (eg. some specificities of the driver).
> 
> A short description is now added to the commit message, I hope this is
> what you wanted, I can reformat the text if needed.

It is ok. Thanks for the update.


>> 2. fix the alignment below
> 
> I don't see the alignment error, I think this is because git adds the
> one '+' character, it should be correct once applied?

Ok. I will check it.

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

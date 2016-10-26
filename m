From: fu.wei@linaro.org (Fu Wei)
Date: Wed, 26 Oct 2016 16:26:58 +0800
Subject: [PATCH v14 2/9] clocksource/drivers/arm_arch_timer: Add a new
 enum for spi type
In-Reply-To: <20161020150933.GK10234@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-3-git-send-email-fu.wei@linaro.org>
 <20161020150933.GK10234@leverpostej>
Message-ID: <CADyBb7t5TdN=MHdai7KbzR4RA1Zd503kZ8pqSJgcT1xK4OaBXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 20 October 2016 at 23:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Sep 29, 2016 at 02:17:10AM +0800, fu.wei at linaro.org wrote:
>> diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
>> index 6f06481..16dcd10 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -45,6 +45,12 @@ enum ppi_nr {
>>       MAX_TIMER_PPI
>>  };
>>
>> +enum spi_nr {
>> +     PHYS_SPI,
>> +     VIRT_SPI,
>> +     MAX_TIMER_SPI
>> +};
>
> Please rename this to arch_timer_spi_nr (as with patch 1 for
> s/ppi_nr/arch_timer_ppi_nr/). With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

OK, NP, done :-)

Great thanks!

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat

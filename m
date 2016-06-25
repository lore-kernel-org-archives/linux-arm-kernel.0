From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 25 Jun 2016 10:05:58 +0200
Subject: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
In-Reply-To: <15462807.mkANpcI9rV@vostro.rjw.lan>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon> <576DA047.7080808@linaro.org>
 <15462807.mkANpcI9rV@vostro.rjw.lan>
Message-ID: <576E3B66.2020600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2016 12:47 AM, Rafael J. Wysocki wrote:

[ ... ]

>>>> +	if (!acpi_disabled)
>>>> +		return psci_acpi_cpu_init_idle(cpu);
>>
>> Is it possible the case where there is information in both the DT and in
>> ACPI ?
>
> No, it isn't.
>
> It is either-or, never both at the same time.

Ok, thanks for the clarification.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

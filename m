From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Thu, 25 Jun 2015 11:16:50 +0530
Subject: Use of pinctrl-single for external device over I2C
In-Reply-To: <20150625043838.GK4156@atomide.com>
References: <55893B2C.1070800@linaro.org> <558A9CC7.6070409@linaro.org>
 <20150624133349.GI4156@atomide.com> <558AE478.2080802@linaro.org>
 <20150625043838.GK4156@atomide.com>
Message-ID: <558B95CA.9070105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 25 June 2015 10:08 AM, Tony Lindgren wrote:
> * Vaibhav Hiremath <vaibhav.hiremath@linaro.org> [150624 10:12]:
>>
>> I do not like this, as this is not HW feature, so DT may not be right
>> approach.
>>
>> So I will dig more from either runtime or Compile time option to use
>> regmap_ Vs raw read/writes.
>
> Can't you just check if the pinctrl node has compatible = "syscon"
> property?
>
> A compile time option won't work for sure. I don't know what you
> would check at runtime as you do not know what the bus is behind
> syscon.
>

Although, I haven't gone through syscon, but not sure whether syscon
would be useful.

As you rightly stated, we need to know the bus behind regmap.

Thanks,
Vaibhav

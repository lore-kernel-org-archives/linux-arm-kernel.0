From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 17 Jun 2016 11:23:35 +0530
Subject: [PATCH V2 4/4] clk: max77686: Add support for MAX77620 clocks
In-Reply-To: <576392B1.9040801@samsung.com>
References: <1466083407-28793-1-git-send-email-ldewangan@nvidia.com>
 <1466083407-28793-5-git-send-email-ldewangan@nvidia.com>
 <576392B1.9040801@samsung.com>
Message-ID: <5763905F.4020504@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Friday 17 June 2016 11:33 AM, Krzysztof Kozlowski wrote:
> On 06/16/2016 03:23 PM, Laxman Dewangan wrote:
>>   config COMMON_CLK_MAX77686
>> -	tristate "Clock driver for Maxim 77686/77802 MFD"
>> -	depends on MFD_MAX77686
>> +	tristate "Clock driver for Maxim 77686/77802/MAX77620 MFD"
> You missed Javier's comment here. Just
> "Maxim 77686/77802/77620"

Sigh.. did not see this comment when going one by one.. really missed..
I will collect all Reviewed/ack/tested and will post V3 with fixing this.

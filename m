From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Sun, 16 Jul 2017 23:57:48 -0500
Subject: [PATCH] iio: adc: rockchip_saradc: add NULL check on
 of_match_device() return value
In-Reply-To: <20170709191007.5d79c950@kernel.org>
References: <20170707065131.GA23382@embeddedgus>
 <20170709191007.5d79c950@kernel.org>
Message-ID: <d3f15aae-160a-1cc9-14dd-c021c2d5a490@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/2017 01:10 PM, Jonathan Cameron wrote:
> On Fri, 7 Jul 2017 01:51:31 -0500
> "Gustavo A. R. Silva" <garsilva@embeddedor.com> wrote:
>
>> Check return value from call to of_match_device()
>> in order to prevent a NULL pointer dereference.
>>
>> In case of NULL print error message and return -ENODEV
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Applied.
>

Thank you, Jonathan.

-- 
Gustavo A. R. Silva

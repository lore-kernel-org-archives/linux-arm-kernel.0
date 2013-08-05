From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Aug 2013 02:03:39 +0900
Subject: [PATCH v2 6/6] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
In-Reply-To: <2236509.stVfXyPhpt@amdc1227>
References: <201307100057.06061.heiko@sntech.de>
 <201307100100.28992.heiko@sntech.de>
 <02cf01ce81f3$6777e5f0$3667b1d0$%kim@samsung.com>
 <2236509.stVfXyPhpt@amdc1227>
Message-ID: <51FFDAEB.60508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/13 02:07, Tomasz Figa wrote:
> On Tuesday 16 of July 2013 16:09:24 Kukjin Kim wrote:

[...]

>>> +	timer at 51000000 {
>>> +		clocks =<&clocks PCLK_PWM>;
>>
>> +		clocks =<&clock PCLK_PWM>;
>>
>> And I'm not sure using definition PCLK_PWM is better here...
>
> Care to explain your doubts about it? I think this is fine.
>
I mean just would be better to use hard coded number here instead of 
PCLK_PWM like others.

- Kukjin

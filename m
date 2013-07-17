From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 17 Jul 2013 14:27:24 +0530
Subject: [PATCH V2] ARM: tegra: enable palmas device for dalmore
In-Reply-To: <51E54FD1.1010404@nvidia.com>
References: <1373441852-27176-1-git-send-email-ldewangan@nvidia.com>
 <51E54FD1.1010404@nvidia.com>
Message-ID: <51E65C74.8060405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 July 2013 07:21 PM, Mikko Perttunen wrote:
> On 07/10/2013 10:37 AM, Laxman Dewangan wrote:
>> +
>> +			palmas_gpio: gpio {
>> +				compatible = "ti,palmas-gpio";
>> +				gpio-controller;
>> +				#gpio-cells = <2>;
>> +			};
> I don't think the palmas-gpio driver ever gets probed since it doesn't
> have device tree compability strings?
>
You will need the patch
[PATCH V3] gpio: palmas: add dt support

which is under review from last few days.

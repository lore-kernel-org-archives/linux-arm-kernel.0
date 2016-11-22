From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 22 Nov 2016 10:38:12 +0100
Subject: [PATCH 0/2] ARM: davinvi: da850 add ohci DT nodes
In-Reply-To: <3543ab96-1a7e-395f-26a6-c748cf0423f1@ti.com>
References: <20161121165920.29809-1-ahaslam@baylibre.com>
 <3543ab96-1a7e-395f-26a6-c748cf0423f1@ti.com>
Message-ID: <CAKXjFTMBiMq3WGpYNfes6i5V8syeR_-VP_ss0KytvTn+Biie4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 10:33 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Monday 21 November 2016 10:29 PM, Axel Haslam wrote:
>> This adds the DT node for the ohci controller and
>> enables it for the omapl138-lckd platform.
>>
>> DEPENDENCIES:
>>
>> 1. [PATCH v6 0/5] USB: ohci-da8xx: Add device tree support
>> https://lkml.org/lkml/2016/11/21/558
>
> Looks like atleast this series is not merged (checking today's linux-next).
>
>>
>> 2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
>> https://lkml.org/lkml/2016/11/4/465
>
> Can you let me know once the dependencies are merged so I can pick these.

Right, the driver changes are not yet picked up, ill ping once those get in.

Regards
Axel.

>
> Thanks,
> Sekhar

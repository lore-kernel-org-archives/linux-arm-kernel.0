From: sophian.yoma@gmail.com (yoma sophian)
Date: Thu, 18 Aug 2016 18:43:53 +0800
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
Message-ID: <CADUS3omw=WYhGF00S3DY8mkg_c-59WvD2AHYs4SQSzCYoHQraQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Sudeep:

2016-08-18 16:47 GMT+08:00 Sudeep Holla <sudeep.holla@arm.com>:
>
>> b. in arm64, if some platform has its own suspend flow,  couldn't it
>> adopts arm/match-xxx to register its own global suspend method?
>>
>
> No, PSCI is highly recommended.
Yes, I agree with you.
But it may not mean the ONLY way for all armv8 platform that support
suspend method is PSCI.

Sincerely appreciate your kind help,

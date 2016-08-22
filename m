From: sophian.yoma@gmail.com (yoma sophian)
Date: Mon, 22 Aug 2016 22:41:15 +0800
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <62cbf1a0-268a-f9f5-09af-c155a8a77508@arm.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
 <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
 <CADUS3onUDk_=UpRoZy1m0hV1VGZYSf22ea8D10MpDbqJCfTkqw@mail.gmail.com>
 <82ddd0e1-9ecc-5e54-e8ee-86f947fc0ecd@arm.com>
 <CADUS3omw=WYhGF00S3DY8mkg_c-59WvD2AHYs4SQSzCYoHQraQ@mail.gmail.com>
 <62cbf1a0-268a-f9f5-09af-c155a8a77508@arm.com>
Message-ID: <CADUS3on-Y63EgUUudhH1cbgihnMmHe_aXra0CG2WEQWRQTo+AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Sudeep:

>> Yes, I agree with you.
>> But it may not mean the ONLY way for all armv8 platform that support
>> suspend method is PSCI.
>
> I would say yes but if you have a real good reason not to adopt PSCI on
> your platform then you can try present that. It should be convincing
> enough to deviate from the standards :)

Since we don't implement full features of PSCI on our platform, that
is why we wants to know whether there is registration of platform
suspend method.

BTW, from the git log, it seems psci.c doesn't register system suspend
until Linux 4.4.
if so, before 4.4, how aarch64 support such as str, echo mem >
/sys/power/state , suspend flow?

appreciate your kind explanation.

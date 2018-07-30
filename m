From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 30 Jul 2018 11:49:53 +0200
Subject: [PATCH] staging/vc04_services: Use __user annotation for
 user-space pointers
In-Reply-To: <CAGR7Keqb6B7bYHM7AFm68K7gyBkMXvM2Z=3uvp4HJ7pW-LURSg@mail.gmail.com>
References: <20180724083217.20921-1-cmaiolino28@gmail.com>
 <20180730085811.GA30820@kroah.com>
 <CAGR7KeoDrp8FBX_H1a8h9hVFF_w9mLXGkvCT6jJAacG7-morRg@mail.gmail.com>
 <f6a7405a-4251-c6b8-470f-d50137fb9b00@i2se.com>
 <CAGR7Keo6zD_M+KHMkK8dDm=oujkwxM7Dv7weT11+oKtJNOZpFA@mail.gmail.com>
 <46f35184-fbb5-985c-a5b1-d6ab27ced8bc@i2se.com>
 <CAGR7Keqb6B7bYHM7AFm68K7gyBkMXvM2Z=3uvp4HJ7pW-LURSg@mail.gmail.com>
Message-ID: <cdcd7246-9cf6-22a9-a828-3b7925480d90@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.07.2018 um 11:43 schrieb Carlos Maiolino:
> On Mon, Jul 30, 2018 at 11:34 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> i think easiest the way would be to get a recent Raspbian Lite (
>> https://www.raspberrypi.org/downloads/raspbian/ ),
>> build the kernel with bcm2835_defconfig, modify config.txt to use the
>> upstream DTB, add the upstream kernel and DTB to boot partition.
>>
>> The following command must be successful:
>>
>> vchiq_test -f 1
> K, I'll take a look and find a way to test it, I don't have a rPI at
> the moment to test
> it, I'll take a look if I can borrow one. in mean time, can it be
> tested somehow in x86 environment?

I don't see a chance because this driver talks to the VC4 firmware.

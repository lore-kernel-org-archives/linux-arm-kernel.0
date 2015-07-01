From: james.morse@arm.com (James Morse)
Date: Wed, 01 Jul 2015 18:32:49 +0100
Subject: [PATCH v3 2/5] PCI: designware: Add ARM64 support
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
References: <1435743817-19083-1-git-send-email-wangzhou1@hisilicon.com>
 <1435743817-19083-3-git-send-email-wangzhou1@hisilicon.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E4BB@lhreml503-mbs>
 <5593F899.6050306@arm.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D4E6A2@lhreml503-mbs>
Message-ID: <55942441.3050705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gabriele Paoloni wrote:
>> Both series are applied to v4.1, use the same .config file, and the
>> same dtb.
>> I will investigate further.
>>
>> (Re-testing v2 works, so this isn't an interim hardware failure)
>
> This is a bit weird....
>
> Patch 2/5 is the only one that affect platforms different from Hisilicon
>
> The only difference between V3 patch[2/5] and v2 patch[2/4] is

Between v3:2/5 and your replacement for v2:2/4, which arrived after I had
tested the v2 series. As the patch has been replaced with a different one -
neither 'tested-by' is true any more.

It looks like the BAR containing the bridge window is not being assigned,
so no devices on bus 1 are discovered.

I will send the full v2 and v3 dmesg output separately.


Thanks,

James

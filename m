From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 17 Aug 2017 10:05:03 -0700
Subject: [GIT PULL 2/3] ARM: Keystone config bits for 4.14
In-Reply-To: <CAK8P3a1B0qYSFfyv1kDU79zKQFAJ_6prb4yuQgCkLR9Tqxp4_Q@mail.gmail.com>
References: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
 <1502929842-8156-2-git-send-email-ssantosh@kernel.org>
 <CAK8P3a1B0qYSFfyv1kDU79zKQFAJ_6prb4yuQgCkLR9Tqxp4_Q@mail.gmail.com>
Message-ID: <7bb8a75b-5de2-419f-6d9b-1a0b6206dc5c@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/17/2017 2:04 AM, Arnd Bergmann wrote:
> On Thu, Aug 17, 2017 at 2:30 AM, Santosh Shilimkar <ssantosh@kernel.org> wrote:
>> The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:
>> ARM: Keystone config bits for 4.14
>>
>> Enables:
>> - Message Manager
>> - TI SCI & GenPD driver
>> - Reset drivers
>> - MMC & regulators
>> - DCAN driver
>>
> 
> Pulled into next/defconfig. Should we also enable all those in
> multi_v7_defconfig?
> 
Yes we could do that.

Regards,
Santosh

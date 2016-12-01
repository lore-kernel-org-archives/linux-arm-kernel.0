From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Dec 2016 19:33:59 +0530
Subject: [PATCH v2 3/3] ARM: dts: da850: Add node for pullup/pulldown
 pinconf
In-Reply-To: <CACRpkdZOxZRRUGkso_b0hLta4OWkeAgX2khcJxFc8EETFKiiXw@mail.gmail.com>
References: <1480351226-3332-1-git-send-email-david@lechnology.com>
 <1480351226-3332-4-git-send-email-david@lechnology.com>
 <CACRpkdZOxZRRUGkso_b0hLta4OWkeAgX2khcJxFc8EETFKiiXw@mail.gmail.com>
Message-ID: <39ef42d3-3a34-70ff-25eb-86006d6841ee@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 November 2016 06:31 PM, Linus Walleij wrote:
> On Mon, Nov 28, 2016 at 5:40 PM, David Lechner <david@lechnology.com> wrote:
> 
>> This SoC has a separate pin controller for configuring pullup/pulldown
>> bias on groups of pins.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes:
>> * Moved pin-controller at 22c00c device node after gpio at 226000 (there seem to be
>>   more nodes in proper order here compared to the i2c at 228000 node suggested by
>>   Sekhar)
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Take this through the ARM SoC tree.

Thanks Linus! Applied to v4.10/dt

Thanks,
Sekhar

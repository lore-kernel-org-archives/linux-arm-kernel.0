From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 28 Jan 2013 21:41:33 +0530
Subject: [PATCH] ARM: davinci: da850: add interrupt-parent property in soc
 node
In-Reply-To: <51069A3A.8090404@ti.com>
References: <1359112724-1217-1-git-send-email-prabhakar.lad@ti.com>
 <51069A3A.8090404@ti.com>
Message-ID: <CA+V-a8vNjbt4RGR99m9LTB7ZsE-RjqSyEHOUPWHAr-7TEv-yug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar,

On Mon, Jan 28, 2013 at 9:03 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On 1/25/2013 4:48 PM, Prabhakar Lad wrote:
>> From: Lad, Prabhakar <prabhakar.lad@ti.com>
>>
>> This patch adds 'interrupt-parent' property in soc node, so that
>> the child inherits this property, this avoids adding 'interrupt-parent'
>> to each node.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: linux-kernel at vger.kernel.org
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Heiko Schocher <hs@denx.de>
>> ---
>
> Looks good to me. Queuing for v3.9. BTW, we are moving the interrupt
> parent property to soc node rather than adding it. So, I think a better
> headline is "move interrupt-parent property to soc node". I change the
> headline while committing.
>
Thanks for fixing it.

Regards,
--Prabhakar

> Thanks,
> Sekhar

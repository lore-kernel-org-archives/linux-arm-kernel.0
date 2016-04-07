From: petr@barix.com (Petr Kulhavy)
Date: Thu, 7 Apr 2016 17:05:07 +0200
Subject: [PATCH 1/3] dt: davinci: use proper address after @
In-Reply-To: <57066FC7.1030706@ti.com>
References: <1459525325-25470-1-git-send-email-petr@barix.com>
 <1459525325-25470-2-git-send-email-petr@barix.com> <57066FC7.1030706@ti.com>
Message-ID: <57067723.90808@barix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.04.2016 16:33, Sekhar Nori wrote:
> On Friday 01 April 2016 09:12 PM, Petr Kulhavy wrote:
>> From: David Lechner <david@lechnology.com>
>>
>> TI has been using the physical address in DT after the @ in device nodes.
>> The device tree convention is to use the same address that is used for
>> the reg property. This updates all davinci DT files to use the proper
>> convention.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> Acked-by: Rob Herring <robh@kernel.org>
> Applied for v4.7. Fixed the subject prefix to "ARM: dts: davinci: " as
> is the convention for device tree updates.
>
> Regards,
> Sekhar
>
Thanks, Sekhar for applying the series.

Regards
Petr

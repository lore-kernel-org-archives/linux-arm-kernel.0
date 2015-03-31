From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 31 Mar 2015 21:00:33 +0530
Subject: [PATCH v2 1/6] phy: miphy365x: Use the generic phy type constants
 in dt-bindings/phy/phy.h
In-Reply-To: <20150331074027.GH9447@x1>
References: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
 <1427728632-10846-2-git-send-email-peter.griffin@linaro.org>
 <551A2D4D.1010601@ti.com> <20150331074027.GH9447@x1>
Message-ID: <551ABD99.2000503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

On Tuesday 31 March 2015 01:10 PM, Lee Jones wrote:
> On Tue, 31 Mar 2015, Kishon Vijay Abraham I wrote:
>
>> Hi Patrice, Maxime,
>>
>> On Monday 30 March 2015 08:47 PM, Peter Griffin wrote:
>>> Now there are generic phy type constants declared in phy.h, migrate over to
>>> using them rather than defining our own. This change has been done as one
>>> atomic commit to be bisectable.
>>>
>>> Note: The values of the defines are the same, so there is no ABI breakage
>>> with this patch.
>>>
>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Lee Jones <lee.jones@linaro.org>
>>
>> Are you okay for this patch to go via PHY tree? It modifies arch/arm/boot/dts
>> /stih416.dtsi.
>
> These files need to be changed simultaneously in order to prevent
> breakage during bisection and the like.  I think the best bet moving
> forward is to pull this into its own branch, tag it and send Maxime a
> pull-request to the immutable branch.  It's the best way to minimise
> merge conflicts during the v4.1 merge window.

okay. I still need an Ack from Maxime.

Thanks
Kishon

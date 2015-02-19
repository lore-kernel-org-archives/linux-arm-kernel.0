From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Wed, 18 Feb 2015 19:48:39 -0500
Subject: amba uarts - arm type uarts fifo size provided by device tree
In-Reply-To: <20150219003409.GX8656@n2100.arm.linux.org.uk>
References: <1424285593-2886-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20150218190601.GI29429@leverpostej> <54E4E916.1010009@linaro.org>
 <20150219003409.GX8656@n2100.arm.linux.org.uk>
Message-ID: <54E532E7.8090008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2015 07:34 PM, Russell King - ARM Linux wrote:
> On Wed, Feb 18, 2015 at 02:33:42PM -0500, Jorge Ramirez-Ortiz wrote:
>> On 02/18/2015 02:06 PM, Mark Rutland wrote:
>>> Hi,
>>>
>>> Please Cc lakml for patches in this area in future.
>>>
>>> On Wed, Feb 18, 2015 at 06:53:11PM +0000, Jorge Ramirez-Ortiz wrote:
>>>> [PATCH 1/2] Documentation: bindings: add optional fifo size property
>>>> [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present
>>>>
>>>>
>>>> These patches aim at resolving an issue present on some of the amba pl011
>>>> uarts.  
>>> Which systems are affected? Neither of your two patches add the property
>>> to any dts file.
>>
>> yes, the system affected is still under revision (I should have mentioned)
>> https://lkml.org/lkml/2015/2/5/144
> Sorry, I can't follow that thread.  What FIFO size do your UARTs have?
> What is the full ID of the UARTs?
>

I just added a temporary printk to my logs for clarity

[    3.328845] name = f7111000.uart, id = 0x241011, amba_rev = 2, fifo size = 64

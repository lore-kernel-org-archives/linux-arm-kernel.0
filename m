From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 26 Sep 2017 10:00:16 +0200
Subject: [RESEND PATCH v5 10/16] ARM: dts: zynq: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <e6006c90-99a2-c8f5-cff2-5c729ada8cd1@xilinx.com>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170615185418.13980-11-javier@dowhile0.org>
 <b22a7db6-7daf-b5c1-3978-cdc699723e30@xilinx.com>
 <CABxcv=n4pCJLPb_C6eYVJ3CLBVH7T0amiJj7mYbshpv4u8xkXA@mail.gmail.com>
 <67a9d32a-0a20-f101-4660-0d5aa5ad8a8a@xilinx.com>
 <CABxcv==nFELQ8JJrxty=oNwwonJ3=xWqaH3a-RYssPmy8x2Z5w@mail.gmail.com>
 <e6006c90-99a2-c8f5-cff2-5c729ada8cd1@xilinx.com>
Message-ID: <CABxcv=kUB4YL+TTJJ-yt41QOW-boFQeNN5V1p2XR1U2AC601NA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 10:06 AM, Michal Simek <michal.simek@xilinx.com> wrote:
> Hi,
>
> On 21.9.2017 11:41, Javier Martinez Canillas wrote:
>> Hello Michal,
>>
>> On Thu, Aug 24, 2017 at 3:44 PM, Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> [snip]
>>
>>>
>>> Ok. Applied to
>>> https://github.com/Xilinx/linux-xlnx/commits/zynq/dt
>>>
>>> Will wait if something else pop up.
>>>
>>
>> I see the patch applied to that repository but I don't see it in
>> neither mainline nor linux-next.
>
> xilinx tree was merging to linux-next but there were conflicts with arm
> soc tree that's why it was removed.
>
>>
>>> Arnd: If you want to take this directly, feel free to do it.
>>>
>>> Thanks,
>>> Michal
>
> It is in queue for v4.15.
>

Got it, thanks a lot for the info.

> FYI: There are still 3 more in doc.
>
> Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt:50:
>                compatible = " ";
> Documentation/devicetree/bindings/i2c/nxp,pca9541.txt:25:
>                compatible = "at,24c08";
> Documentation/devicetree/bindings/trivial-devices.txt:34:at,24c08
>        i2c serial eeprom  (24cxx)
>

Indeed, thanks for pointing out. I'll take a look to these as well.

>
> Thanks,
> Michal
>

Best regards,
Javier

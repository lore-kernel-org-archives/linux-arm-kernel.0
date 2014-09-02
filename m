From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 2 Sep 2014 08:28:46 +0100
Subject: [PATCH] mfd: palmas: Add support for optional wakeup
In-Reply-To: <5404BB31.3060001@ti.com>
References: <1408457197-30487-1-git-send-email-nm@ti.com>
 <20140829105619.GH24579@lee--X1> <54007515.5080506@ti.com>
 <20140901093206.GJ7374@lee--X1> <5404BB31.3060001@ti.com>
Message-ID: <20140902072846.GC17117@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Sep 2014, Nishanth Menon wrote:

> On 09/01/2014 04:32 AM, Lee Jones wrote:
> >On Fri, 29 Aug 2014, Nishanth Menon wrote:
> >>On 08/29/2014 05:56 AM, Lee Jones wrote:
> >>>On Tue, 19 Aug 2014, Nishanth Menon wrote:
> >>>
> >>>>With the recent pinctrl-single changes, omaps can treat wake-up events
> >>>>from deeper idle states as interrupts.
> >>>>
> >>>>Let's add support for the optional second interrupt for wake-up
> >>>>events. And then SoC can wakeup and handle the event using it's
> >>>>regular handler.
> >>>>
> >>>>Finally, to pass the wake-up interrupt in the dts file,
> >>>>interrupts-extended property needs to be passed.
> >>>>
> >>>>This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> >>>>support for optional wake-up")
> >>>>
> >>>>Signed-off-by: Nishanth Menon <nm@ti.com>
> >>>>---
> >>>>  Documentation/devicetree/bindings/mfd/palmas.txt |   20 ++++++++
> >>>
> >>>DT Ack please.
> >
> >Please read Documentation/devicetree/bindings/submittingpatches.txt
> 
> I assume you wanted me to note the following:
> "
> The Documentation/ portion of the patch should be a separate patch.
> "
> 
> Many maintainers prefer that when the bindings for the device is
> new, and when additional properties are added, they prefer it part
> of same patch.. Anyways.. if the above is what you prefer, I can
> follow that.

I tend to like it done properly please.

> In short, I assume you'd like three patches:
> a) fix up style of current documentation - palmas to palmas at 40
> b) Split documentation for interrupt-extended from the current patch
> into it's own patch.
> c) remainder of this patch as is..
> 
> Does that sound right?

That does, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 22 May 2014 19:30:23 +0300
Subject: [Patch v5 3/7] mfd: ti-keystone-devctrl: add bindings for device
 state control
In-Reply-To: <537E224E.3060601@ti.com>
References: <1400766516-14537-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1400766516-14537-4-git-send-email-ivan.khoronzhuk@ti.com>
 <20140522141432.GA19747@lee--X1> <537E0A87.5010408@ti.com>
 <20140522153309.GB19747@lee--X1> <537E224E.3060601@ti.com>
Message-ID: <537E261F.10401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/22/2014 07:14 PM, Ivan Khoronzhuk wrote:
>
> On 05/22/2014 06:33 PM, Lee Jones wrote:
>>>> Why do I only have this patch?  Where is the rest of the set?  Also,
>>>> it's on v5 and I don't recall seeing the other 4 versions?
>>> It's strange I've sent whole series on
>>>
>>> linux-kernel at vger.kernel.org
>>> linux-arm-kernel at lists.infradead.org
>>> linux-doc at vger.kernel.org
>>> devicetree at vger.kernel.org
>>>
>>> v4 is also was sent to lists in question:
>>> https://lkml.org/lkml/2014/5/21/359
>> But did you send them to me?  I don't parse the list.
>>
>
> Sorry.
> Becouse /scripts/get_maintainer.pl  patches/reset_driver_v6/* hadn't 
> been listed you
> It's because there is no patch with "code" for the bindings you've 
> comment.
>
> I should check it by hand for mtd.
>
> The bindings for mtd device_state_control were added only on v5
> And it's added only to describe what is the node we've used in a 
> keystone DT.
> The node is planned to be used only via syscon phandle, there is no 
> driver for it,
> and compatible string for "ti,keystone-devctrl" added only to be 
> matched by
> a high-level device driver if needed.
>
> I'll send new v6 series to you also.
> Once again sorry.
>

s/mtd/mfd

-- 
Regards,
Ivan Khoronzhuk

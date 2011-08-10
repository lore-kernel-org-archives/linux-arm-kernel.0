From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 10 Aug 2011 20:06:37 +0200
Subject: [RFC/PATCH 09/14] dt: omap: prepare hwmod to support dt
In-Reply-To: <CAC63_iSX0cjauOj=CcTABqgSWAgYRE_G7Qio5y2BrpeRnkhEWQ@mail.gmail.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
	<1312897232-4792-10-git-send-email-manjugk@ti.com>	<4E4270D3.8070807@ti.com>
	<20110810162846.GC2091@manju-desktop>	<4E42BBBF.9060900@ti.com>
	<CAC63_iSX0cjauOj=CcTABqgSWAgYRE_G7Qio5y2BrpeRnkhEWQ@mail.gmail.com>
Message-ID: <4E42C8AD.8000609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/10/2011 8:03 PM, G, Manjunath Kondaiah wrote:
> On Wed, Aug 10, 2011 at 10:41 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 8/10/2011 6:28 PM, G, Manjunath Kondaiah wrote:
>>>
>>> On Wed, Aug 10, 2011 at 01:51:47PM +0200, Cousson, Benoit wrote:
>>>>
>>>> Hi Manju,
>>>>
>>>> On 8/9/2011 4:10 PM, G, Manjunath Kondaiah wrote:
>>>>>
>>>>> The omap dt requires new omap hwmod api to be added for in order
>>>>> to support omap dt.
>>>>
>>>> Both the subject and the changelog are misleading. You are not doing
>>>> any hwmod stuff in it.
>>>> You are just passing an "of_node" pointer during omap_device_build_ss.
>>>>
>>>> The subject should start with OMAP: omap_device: because it does not
>>>> belong to the DT subsystem.
>>>> The same comment apply to most patches in that series.
>>>
>>> The goal of this patch is to make omap-hwmod ready for dt adaptation hence
>>> I used the title "dt: omap: prepare hwmod to support dt" and "of_node"
>>> pointer
>>> is passed from dt and it is required for dt build.
>>
>> I think that the goal of this patch is to update the omap_device_build_ss
>> API in order to provide a device tree node pointer to pdev. For the moment
>> there is nothing related to hwmod.
> yes. it is to update  *_ss api with device node pointer and introduce new
> api exported for dt builds.  I can update with this description.
>>
>>> And as you mentioned, patch does not do anything related to omap_device.
>>
>> You meant omap_hwmod?
>
> Yes. It should be "omap: omap_hwmod: add device node pointer"

... "OMAP: omap_device: Add device tree node pointer"

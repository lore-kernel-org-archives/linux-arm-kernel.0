From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 10 Jan 2013 10:58:14 +0100
Subject: [PATCH v3 0/3] ARM: dts: omap: add dt data for MUSB
In-Reply-To: <50EE5D61.1020307@ti.com>
References: <1348047128-25692-1-git-send-email-kishon@ti.com>
 <505A8BAB.2020004@ti.com> <20121227183524.GB7097@blackmetal.musicnaut.iki.fi>
 <50EE5D61.1020307@ti.com>
Message-ID: <50EE90B6.2060308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 01/10/2013 07:19 AM, kishon wrote:
> On Friday 28 December 2012 12:05 AM, Aaro Koskinen wrote:
>> Hi,
>>
>> On Thu, Sep 20, 2012 at 05:21:15AM +0200, Benoit Cousson wrote:
>>> On 09/19/2012 11:32 AM, Kishon Vijay Abraham I wrote:
>>>> This patch series adds dt data to get MUSB working in omap4 and omap3
>>>>
>>>> Changes from v2:
>>>> * Changes the subject of all the patches to include "ARM: dts:"
>>>> * Added reg property and interrupt property for "usb_otg_hs".
>>>> Previously these
>>>>    were obtained from ti,hwmods property.
>>>> * Rebased on
>>>>   
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
>>>> devel-dt
>>>>
>>>> Changes from v1:
>>>> Just removed the omap-usb2 dt data and sent that as a separate patch.
>>>>
>>>> Kishon Vijay Abraham I (3):
>>>>    ARM: dts: Add twl6030-usb data
>>>>    ARM: dts: Add twl4030-usb data
>>>>    ARM: dts: omap: Add usb_otg and glue data
>>>
>>> Thanks for the update. I've just pulled the series for 3.7.
>>
>> I wonder what happened to the patch #3 (Add usb_otg and glue data)
>> of this series? Why was it dropped? I cannot see it in 3.7 or 3.8-rc1.

I don't remember the context, can you repost it rebased on 3.8-rc2? Did
it generate some discussion at that time?

Benoit

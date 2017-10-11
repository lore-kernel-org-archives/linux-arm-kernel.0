From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 11 Oct 2017 14:50:10 +0300
Subject: [PATCHv2 0/7] Add support for USB OTG on STM32F7
In-Reply-To: <04a49088-b615-d7b8-0387-e7bfa32ee19f@st.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
 <878tgim24i.fsf@linux.intel.com>
 <04a49088-b615-d7b8-0387-e7bfa32ee19f@st.com>
Message-ID: <87vajllx8t.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Alexandre Torgue <alexandre.torgue@st.com> writes:
> Hi Felip
>
> On 10/11/2017 12:04 PM, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> Amelie Delaunay <amelie.delaunay@st.com> writes:
>>> The STM32F7 MCU family embeds two DWC2 USB OTG cores. One core is USB
>>> OTG FS and the other is USB OTG HS. The USB FS core only works with its
>>> internal phy whilst the USB HS core can work in HS with external ULPI phy
>>> or in FS/LS with the on-chip FS phy.
>>>
>>> Amelie Delaunay (7):
>>>    dt-bindings: usb: Document the STM32F7 DWC2 USB OTG HS core binding
>>>    usb: dwc2: add support for STM32F7 USB OTG HS
>>>    ARM: dts: stm32: Add USB HS support for STM32F746 MCU
>> 
>> I have applied these three patches. Should I take the rest? They seems
>> like they could go upstream through the ARM maintainers.
>> 
>
> I will take other DT patches in my PR.
>
> Concerning "ARM: dts: stm32: Add USB HS support for STM32F746 MCU" patch 
> I prefer also to take it. This patch adds some pinctrl groups but stm32 
> pinctrl bindings will change in my next PR (we will use a macro to 
> define pins instead of using defined values). So if you push the DT 
> patch through your pull request there will be a merge issue.
> It is possible that I take also this one ?

In that case, it's best if you take them all :-) Here's my Ack:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

I'll drop them from my tree now

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171011/8722cedb/attachment.sig>

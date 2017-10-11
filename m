From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Wed, 11 Oct 2017 13:04:45 +0300
Subject: [PATCHv2 0/7] Add support for USB OTG on STM32F7
In-Reply-To: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
References: <1503930018-536-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <878tgim24i.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Amelie Delaunay <amelie.delaunay@st.com> writes:
> The STM32F7 MCU family embeds two DWC2 USB OTG cores. One core is USB
> OTG FS and the other is USB OTG HS. The USB FS core only works with its
> internal phy whilst the USB HS core can work in HS with external ULPI phy
> or in FS/LS with the on-chip FS phy.
>
> Amelie Delaunay (7):
>   dt-bindings: usb: Document the STM32F7 DWC2 USB OTG HS core binding
>   usb: dwc2: add support for STM32F7 USB OTG HS
>   ARM: dts: stm32: Add USB HS support for STM32F746 MCU

I have applied these three patches. Should I take the rest? They seems
like they could go upstream through the ARM maintainers.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171011/13185691/attachment.sig>

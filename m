From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 5 Apr 2017 15:29:00 +0530
Subject: [PATCH 1/3] phy: sun4i-usb: enable PHY0 dual route switching for
 A64 USB PHY
In-Reply-To: <20170405070351.etpupeqjeo7dhyxl@lukather>
References: <20170404184518.33610-1-icenowy@aosc.io>
 <20170405070351.etpupeqjeo7dhyxl@lukather>
Message-ID: <41abab5b-1776-4cd4-f280-bfa7f69db9ad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 05 April 2017 12:33 PM, Maxime Ripard wrote:
> On Wed, Apr 05, 2017 at 02:45:16AM +0800, Icenowy Zheng wrote:
>> Allwinner A64 SoC features a switchable PHY0 like the one in H3, which
>> can switch between a MUSB controller and a pair of OHCI/EHCI controller.
>>
>> Enable PHY0 route auto switching for A64.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

merged, thanks.

-Kishon

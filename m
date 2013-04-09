From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 9 Apr 2013 14:25:05 +0530
Subject: [PATCH] ARM: OMAP4: HWMOD: make 'ocp2scp_usb_phy_phy_48m" as
 the main clock
In-Reply-To: <5163D72B.5040205@ti.com>
References: <1365496101-7829-1-git-send-email-kishon@ti.com>
 <5163D72B.5040205@ti.com>
Message-ID: <5163D769.1040401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 09 April 2013 02:24 PM, Benoit Cousson wrote:
> Hi Kishon,
>
> On 04/09/2013 10:28 AM, Kishon Vijay Abraham I wrote:
>> commit 92702d (ARM: OMAP4: PM: fix PM regression introduced by recent
>> clock cleanup) makes the 'ocp2scp_usb_phy_phy_48m' as optional
>> functional clock causing regression in MUSB. But this 48MHz clock is a
>> mandatory clock for usb phy attached to ocp2scp and hence made as the main
>> clock for ocp2scp.
>
> It is a fix for 3.9-rcX?

Yeah.

Thanks
Kishon

From: pku.leo@gmail.com (Leo Li)
Date: Fri, 7 Oct 2016 17:46:56 -0500
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <DB5PR0401MB1925E5980009DD23FA9C7D50F5C90@DB5PR0401MB1925.eurprd04.prod.outlook.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3596831.dckG5peiyF@wuerfel>
 <DB5PR0401MB1925CDF6CBD45ACBEE95D152F5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
 <20042182.GcPMJken6Z@wuerfel>
 <DB5PR0401MB1925E5980009DD23FA9C7D50F5C90@DB5PR0401MB1925.eurprd04.prod.outlook.com>
Message-ID: <CADRPPNQL=Tekj2RmFw2LdbHpMvXsUrUKCFLYZnppGw7G7M5cJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 12:02 AM, Sriram Dash <sriram.dash@nxp.com> wrote:
>>From: Arnd Bergmann [mailto:arnd at arndb.de]
>>On Wednesday, September 21, 2016 11:43:59 AM CEST Sriram Dash wrote:
>>> >From: Arnd Bergmann [mailto:arnd at arndb.de] On Wednesday, September
>>> >21, 2016 11:06:47 AM CEST Sriram Dash wrote:
>>>
>>> ==============================================================
>>> From 8b0dea1513e9e73a11dcfa802ddc71cca11d66f8 Mon Sep 17 00:00:00 2001
>>> From: Sriram Dash <sriram.dash@nxp.com>
>>> Date: Wed, 21 Sep 2016 11:39:30 +0530
>>> Subject: [PATCH] usb: xhci: Fix the patch inherit dma configuration
>>> from  parent dev
>>>
>>> Fixes the patch https://patchwork.kernel.org/patch/9319527/
>>> ("usb: dwc3: host: inherit dma configuration from parent dev").
>>>
>>> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
>>> ---
>>>  drivers/usb/host/xhci-mem.c | 12 ++++++------
>>>  drivers/usb/host/xhci.c     | 20 ++++++++++----------
>>>  2 files changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>>> index 6afe323..79608df 100644
>>> --- a/drivers/usb/host/xhci-mem.c
>>> +++ b/drivers/usb/host/xhci-mem.c
>>
>>All the changes you did to this file seem fine, I completely missed that part.
>>
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c index
>>> 01d96c9..9a1ff09 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>
> Yes. Some sanity is required over this patch.

Hi Sriram,

Have you been able to do the sanity check on the patch?  I will be
good to have the formal patch submitted for integration as soon as
possible because the dwc3 USB functionality has been broken for a
while in upstream kernel.

Regards,
Leo

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Sep 2016 11:47:14 +0200
Subject: [PATCH 1/1] ARM: keystone: defconfig: Fix USB configuration
In-Reply-To: <af658fe2-1555-e653-ad5e-54bec9bfd037@ti.com>
References: <1471430690-17143-1-git-send-email-rogerq@ti.com>
 <b04edb50-4f64-72a3-1a08-0586e354fd52@oracle.com>
 <af658fe2-1555-e653-ad5e-54bec9bfd037@ti.com>
Message-ID: <5628750.OeK8ZAbbh7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 12, 2016 2:33:57 PM CEST Roger Quadros wrote:
> On 25/08/16 19:39, Santosh Shilimkar wrote:
> > Ping !!
> > 
> > On 8/17/2016 9:23 AM, Santosh Shilimkar wrote:
> >> Hi Arnd, Olof,
> >>
> >> Can you please pick-up the fix for 4.8-rcx ?
> >> Roger reported that USB ports are broken on Keystone2 boards
> >> since v4.8-rc1 because USB_HPY config option got dropped.
> >>
> >>
> >> On 8/17/2016 3:44 AM, Roger Quadros wrote:
> >>> Simply enabling CONFIG_KEYSTONE_USB_PHY doesn't work anymore
> >>> as it depends on CONFIG_NOP_USB_XCEIV. We need to enable
> >>> that as well.
> >>>
> >>> This fixes USB on Keystone boards from v4.8-rc1 onwards.
> >>>
> >>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>> ---
> >> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> 
> Gentle reminder.
> This is still missing in v4.8-rc6.
> 
> 

Applied to the fixes branch now, sorry for missing the
previous reminder.

	Arnd

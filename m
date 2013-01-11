From: rogerq@ti.com (Roger Quadros)
Date: Fri, 11 Jan 2013 11:40:32 +0200
Subject: [PATCH 01/14] mfd: omap-usb-host: Consolidate OMAP USB-HS platform
 data
In-Reply-To: <20130110234537.GB15458@atomide.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
 <1357836694-30788-2-git-send-email-rogerq@ti.com>
 <20130110234537.GB15458@atomide.com>
Message-ID: <50EFDE10.9080902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 01/11/2013 01:45 AM, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [130110 08:54]:
>> Let's have a single platform data structure for the OMAP's High-Speed
>> USB host subsystem instead of having 3 separate ones i.e. one for
>> board data, one for USB Host (UHH) module and one for USB-TLL module.
>>
>> This makes the code much simpler and avoids creating multiple copies of
>> platform data.
> 
> I can apply just this patch alone into an immutable branch that
> we all can merge in as needed as long as we have acks for the USB
> and MFD parts.
> 
> Or does this one need to be changed based on Alan's comments
> on the EHCI lib related changes?
> 

This does not depend on EHCI lib based changes but it depends on the
OMAP USB Host cleanup series posted earlier.

regards,
-roger

From: rogerq@ti.com (Roger Quadros)
Date: Fri, 8 Feb 2013 10:56:32 +0200
Subject: [PATCH 02/10] USB: EHCI: make ehci-omap a separate driver
In-Reply-To: <20130208074229.GA21879@arwen.pp.htv.fi>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e5db.c84e420a.08c3.ffffbe6b@mx.google.com>
 <20130208074229.GA21879@arwen.pp.htv.fi>
Message-ID: <5114BDC0.5060307@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 09:42 AM, Felipe Balbi wrote:
> HI,
> 
> On Thu, Feb 07, 2013 at 11:03:59PM +0530, manjunath.goudar at linaro.org wrote:
>> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>>
>> Separate the OMAP host controller driver from ehci-hcd host code
>> into its own driver module.
>>
>> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
>> Signed-off-by: Arnd Bergmann <arnd@linaro.org>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Greg KH <greg@kroah.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: linux-usb at vger.kernel.org
>> Cc: Tony Lindgren <tony@atomide.com>
> 
> Alan and Roger have already been working on this for ehci-omap. Their
> patches might already be in Greg's queue...
> 

Manjunath,

ehci-omap will be taken care of so in [1] so you can please skip it
from your patches. Thanks.

cheers,
-roger

[1] https://patchwork.kernel.org/patch/2055131/

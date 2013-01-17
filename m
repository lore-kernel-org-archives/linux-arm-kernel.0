From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 15:30:07 +0200
Subject: [PATCH v7 22/22] mdf: omap-usb-host: get rid of build warning
In-Reply-To: <20130117115046.GI18978@arwen.pp.htv.fi>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-23-git-send-email-rogerq@ti.com>
 <20130117115046.GI18978@arwen.pp.htv.fi>
Message-ID: <50F7FCDF.7040808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 01:50 PM, Felipe Balbi wrote:
> On Thu, Jan 17, 2013 at 01:30:31PM +0200, Roger Quadros wrote:
>> Fixes the below build warning when driver is built-in.
>>
>> drivers/mfd/omap-usb-host.c:750:12: warning:
>> ?usbhs_omap_remove? defined but not used [-Wunused-function]
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> should this go to stable too ?
> 
> (though it's not really a bug, so doesn't really matter, I guess).
> 
not a bug so let's not send this to stable.

--
cheers,
-roger

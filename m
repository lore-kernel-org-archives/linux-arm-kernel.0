From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 14:46:48 +0200
Subject: [PATCH v7 18/22] USB: ehci-omap: Don't free gpios that we didn't
 request
In-Reply-To: <20130117114838.GH18978@arwen.pp.htv.fi>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-19-git-send-email-rogerq@ti.com>
 <20130117114838.GH18978@arwen.pp.htv.fi>
Message-ID: <50F7F2B8.8050500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2013 01:48 PM, Felipe Balbi wrote:
> On Thu, Jan 17, 2013 at 01:30:27PM +0200, Roger Quadros wrote:
>> This driver does not request any gpios so don't free them.
>> Fixes L3 bus error on multiple modprobe/rmmod of ehci_hcd
>> with ehci-omap in use.
>>
>> CC: Alan Stern <stern@rowland.harvard.edu>
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> should this go to stable ?
> 
Yes it should.

--
cheers,
-roger

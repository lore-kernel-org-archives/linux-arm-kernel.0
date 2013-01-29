From: rogerq@ti.com (Roger Quadros)
Date: Tue, 29 Jan 2013 17:33:33 +0200
Subject: [PATCH v3 10/30] USB: ehci-omap: Use PHY APIs to get the PHY
 device and put it out of suspend
In-Reply-To: <Pine.LNX.4.44L0.1301291026020.1507-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1301291026020.1507-100000@iolanthe.rowland.org>
Message-ID: <5107EBCD.8000406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2013 05:30 PM, Alan Stern wrote:
> On Tue, 29 Jan 2013, Roger Quadros wrote:
> 
>> For each port that is in PHY mode we obtain a PHY device using the USB PHY
>> library and put it out of suspend.
>>
>> It is up to platform code to associate the PHY to the controller's
>> port and it is upto the PHY driver to manage the PHY's resources.
> 
> s/upto/up to/
> 
>> Also remove wired spacing around declarations we come across.
> 
> s/wired/weird/ -- not that people care about misspellings in the 
> Changelog.  You don't have to resubmit the patch just to fix these two 
> items.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 

Thanks Alan. I'll fix them in the pull request.

cheers,
-roger

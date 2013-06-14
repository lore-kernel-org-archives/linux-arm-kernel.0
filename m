From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 14 Jun 2013 11:05:44 +0530
Subject: [RFC PATCH 1/4] arm: omap: Add phy binding info for musb in plat
 data
In-Reply-To: <51B9C3B6.1080707@ti.com>
References: <1368796954-3499-1-git-send-email-kishon@ti.com>
 <51A43E0A.8090201@ti.com> <51B9C3B6.1080707@ti.com>
Message-ID: <51BAABB0.5060107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 13 June 2013 06:35 PM, Tomi Valkeinen wrote:
> Hi,
>
> On 28/05/13 08:18, Kishon Vijay Abraham I wrote:
>> Hi Tony,
>>
>> On Friday 17 May 2013 06:52 PM, Kishon Vijay Abraham I wrote:
>>> In order for controllers to get PHY in case of non dt boot, the phy
>>> binding information (phy label) should be added in the platform
>>> data of the controller.
>>
>> This series would be needed to get MUSB working in OMAP3 boards for
>> non-dt boot case. Do you think this is good enough to go in this rc cycle?
>
> Did this or some other solution go forward? I'm still unable to boot
> with usb-gadget-ethernet with v3.10-rc5.

No. I think Tony is ok to take this only during next merge window.

Thanks
Kishon

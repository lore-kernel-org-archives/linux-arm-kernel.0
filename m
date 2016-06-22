From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 22 Jun 2016 11:35:00 +0530
Subject: [PATCH v5] phy-sun4i-usb: Fix irq free conditions to match
 request conditions
In-Reply-To: <720c35c7-eb9a-2881-cb95-39fa6aa61dee@cogentembedded.com>
References: <1466242293-22393-1-git-send-email-hdegoede@redhat.com>
 <720c35c7-eb9a-2881-cb95-39fa6aa61dee@cogentembedded.com>
Message-ID: <576A2A8C.7090403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 18 June 2016 05:03 PM, Sergei Shtylyov wrote:
> On 6/18/2016 12:31 PM, Hans de Goede wrote:
> 
>> commit 5cf700ac9d50("phy: phy-sun4i-usb: Fix optional gpios failing probe")
>> changed the condition under which irqs are requested, but omitted matching
>> changes to sun4i_usb_phy_remove(). This commit fixes this.
>>
>> Fixes: commit 5cf700ac9d50("phy: phy-sun4i-usb: Fix optional gpios failing
>> probe")
> 
>    "Commit" not needed here, this tag has a standardized format.

Fixed it myself and applied.

Thanks
Kishon

From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 16 Aug 2017 09:19:57 +0900
Subject: [PATCH v2 4/5] usb: gadget: udc: Replace the deprecated extcon API
In-Reply-To: <87mv716u12.fsf@linux.intel.com>
References: <1501748448-26821-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170803082050epcas1p2491eedf2f26510f55cd15ce777356fce@epcas1p2.samsung.com>
 <1501748448-26821-5-git-send-email-cw00.choi@samsung.com>
 <87mv716u12.fsf@linux.intel.com>
Message-ID: <59938FAD.1000601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017? 08? 15? 18:48, Felipe Balbi wrote:
> 
> Hi,
> 
> Chanwoo Choi <cw00.choi@samsung.com> writes:
>> This patch replaces the deprecated extcon API as following:
>> - extcon_get_cable_state_() -> extcon_get_state()
>>
>> Cc: Felipe Balbi <balbi@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Raviteja Garimella <raviteja.garimella@broadcom.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Do you want to take these through your tree or mine? In case you want
> them in your tree:
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> 

Thanks for review. These patches included the patch related to extcon (patch5).
So, After creating the immutable branch, I'll send the pull request to both
phy and usb maintainers.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

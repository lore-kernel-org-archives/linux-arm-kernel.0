From: rogerq@ti.com (Roger Quadros)
Date: Tue, 25 Feb 2014 11:40:22 +0200
Subject: [PATCH v8 01/14] mfd: omap-usb-host: Get clocks based on hardware
 revision
In-Reply-To: <20140225093759.GA22755@lee--X1>
References: <1392896409-5101-1-git-send-email-rogerq@ti.com>
 <1392896409-5101-2-git-send-email-rogerq@ti.com>
 <20140225093759.GA22755@lee--X1>
Message-ID: <530C6506.5050607@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2014 11:37 AM, Lee Jones wrote:
>> Not all revisions have all the clocks so get the necessary clocks
>> based on hardware revision.
>>
>> This should avoid un-necessary clk_get failure messages that were
>> observed earlier.
>>
>> CC: Lee Jones <lee.jones@linaro.org>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-host.c | 43 ++++++++++++++++++++++++++++++++-----------
>>  1 file changed, 32 insertions(+), 11 deletions(-)
> 
> What about patches 1 and 2. Are these safe to go in alone?
> 
patch 6 must not go in without 1. I've just asked Mike if we can squash it into 1.

patch 2 can go alone.

cheers,
-roger

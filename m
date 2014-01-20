From: rogerq@ti.com (Roger Quadros)
Date: Mon, 20 Jan 2014 11:14:55 +0200
Subject: [PATCH v5 3/9] mfd: omap-usb-host: Update DT clock binding
 information
In-Reply-To: <20140110101107.GF28141@lee--X1>
References: <1389269303-30465-1-git-send-email-rogerq@ti.com>
 <1389269303-30465-4-git-send-email-rogerq@ti.com>
 <20140110101107.GF28141@lee--X1>
Message-ID: <52DCE90F.8040908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2014 12:11 PM, Lee Jones wrote:
> On Thu, 09 Jan 2014, Roger Quadros wrote:
> 
>> The omap-usb-host driver expects certained named clocks.
>> Add this information to the DT binding document.
>>
>> Use clock names as per function for reference clocks.
>>
>> CC: Lee Jones <lee.jones@linaro.org>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/mfd/omap-usb-host.txt      | 23 ++++++++++++++++++++++
>>  drivers/mfd/omap-usb-host.c                        |  6 +++---
>>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> Please don't mix up binding changes with code ones.
> 
> Separate patch please.
> 
OK.

cheers,
-roger

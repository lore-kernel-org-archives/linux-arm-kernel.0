From: cov@codeaurora.org (Christopher Covington)
Date: Fri, 24 Jan 2014 12:55:13 -0500
Subject: [PATCH V4 5/5] Documentation: power: reset: Add documentation
 for generic SYSCON reboot driver
In-Reply-To: <20140124113920.GF814@e106331-lin.cambridge.arm.com>
References: <1390504801-24483-1-git-send-email-fkan@apm.com>
 <1390504801-24483-6-git-send-email-fkan@apm.com>
 <20140124113920.GF814@e106331-lin.cambridge.arm.com>
Message-ID: <52E2A901.4050707@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2014 06:39 AM, Mark Rutland wrote:
> On Thu, Jan 23, 2014 at 07:20:01PM +0000, Feng Kan wrote:
>> Add documentation for generic SYSCON reboot driver.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  .../bindings/power/reset/syscon-reboot.txt         |   16 ++++++++++++++++
>>  1 files changed, 16 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
>> new file mode 100644
>> index 0000000..e9eb1fe
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
>> @@ -0,0 +1,16 @@
>> +Generic SYSCON mapped register reset driver
> 
> Bindings should describe hardware, not drivers.

How is this different than what's done for PSCI?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.

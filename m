From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 9 Sep 2011 02:32:12 +0200
Subject: [RFC PATCH 07/10] documentation/dt: Add spinlock bindings
In-Reply-To: <20110908181001.GF2967@ponder.secretlab.ca>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
	<1314191356-10963-8-git-send-email-b-cousson@ti.com>
	<20110908181001.GF2967@ponder.secretlab.ca>
Message-ID: <4E695E8C.10505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2011 8:10 PM, Grant Likely wrote:
> On Wed, Aug 24, 2011 at 03:09:13PM +0200, Benoit Cousson wrote:
>> Add documentation for the HW spinlock in OMAP4.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Randy Dunlap<rdunlap@xenotime.net>
>> ---
>>   .../bindings/hwspinlock/omap-spinlock.txt          |    5 +++++
>>   1 files changed, 5 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
>>
>> diff --git a/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt b/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
>> new file mode 100644
>> index 0000000..36ac074
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwspinlock/omap-spinlock.txt
>> @@ -0,0 +1,5 @@
>> +HW spinlock on OMAP platform:
>> +
>> +Required properties:
>> +- compatible : Must be "ti,omap-spinlock";
>
> "ti,omap-*" is probably too generic. omap3-spinlock or omap4-spinlock
> would be better.

For that IP, we do not have any real IP version documented, so I do agree.
Since it is a new OMAP4 IP, I'll use omap4-spinlock.

Benoit

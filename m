From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 20 Mar 2017 11:55:27 +0530
Subject: [PATCH v6 5/8] dt-bindings: input: touchscreen: Add max11801-ts
 binding
In-Reply-To: <20170320023622.GA3443@dragon>
References: <1489647939-4966-1-git-send-email-jagan@openedev.com>
 <20170320023622.GA3443@dragon>
Message-ID: <CAMty3ZC=mS6L8ajEnZDPJsvMvOH0NF5MBHdc+MYofBXBfe9JXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 8:06 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Mar 16, 2017 at 12:35:38PM +0530, Jagan Teki wrote:
>> From: Jagan Teki <jagan@amarulasolutions.com>
>>
>> Add missing documentation of max11801-ts dt-binding details.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Cc: Michael Trimarchi <michael@amarulasolutions.com>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>> Changes for v6:
>> - Replace the lable and name of the node
>>    ts: max11801 => max11801: touchscreen at 48
>> Changes for v5:
>> - Newly added patch
>>
>>  .../bindings/input/touchscreen/max11801-ts.txt         | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
>> new file mode 100644
>> index 0000000..4afccbe
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
>> @@ -0,0 +1,18 @@
>> +* MAXI MAX11801 Resistive touch screen controller with i2c interface
>> +
>> +Required properties:
>> +- compatible: must be "max11801"
>
> Shouldn't it have a vendor prefix?

Drivers i2c_device_id.name doesn't have vendor prefix, should I fix
that one as well?

thanks!
-- 
Jagan Teki
Senior Linux Kernel Engineer | Amarula Solutions
U-Boot, Linux | Upstream Maintainer
Hyderabad, India.

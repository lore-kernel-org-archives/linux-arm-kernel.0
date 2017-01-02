From: woogyom.kim@gmail.com (Milo Kim)
Date: Mon, 2 Jan 2017 16:45:43 +0900
Subject: [PATCH v3 1/3] ARM: dts: imx6: Add Savageboard common file
In-Reply-To: <20170102074155.GG20956@dragon>
References: <20161209010436.7994-1-woogyom.kim@gmail.com>
 <20161209010436.7994-2-woogyom.kim@gmail.com> <20170102065239.GC20956@dragon>
 <450d89c7-7459-6369-3a07-cc60d70de0db@gmail.com>
 <20170102074155.GG20956@dragon>
Message-ID: <0077a5bb-60ea-a4d6-0cab-08bdfdd4f57d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/02/2017 04:41 PM, Shawn Guo wrote:
> On Mon, Jan 02, 2017 at 04:31:07PM +0900, Milo Kim wrote:
>>
>> On 01/02/2017 03:52 PM, Shawn Guo wrote:
>>>> +	panel {
>>>> +		compatible = "avic, tm097tdh02", "hannstar,hsd100pxn1";
>>> "avic, tm097tdh02" is an undocumented compatible.
>>>
>>
>> AVIC TM097TDH02 panel is compatible with Hannstar HSD100PXN1, so I
>> reuse it. It's the same rule as the usage of imx6q I2C controller.
>>
>> 	i2c2: i2c at 021a4000 {
>> 		compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
>> 	};
>
> Okay.  Drop the space in the middle of the compatible.

Thanks for all your feedback. Please let me submit the v4 later.

Best regards,
Milo

From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 29 May 2013 11:08:46 +0530
Subject: [PATCH v6 1/9] drivers: phy: add generic PHY framework
In-Reply-To: <51A531A9.4030800@gmail.com>
References: <1367229812-30574-1-git-send-email-kishon@ti.com>
 <1367229812-30574-2-git-send-email-kishon@ti.com>
 <51A531A9.4030800@gmail.com>
Message-ID: <51A59466.6090504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 29 May 2013 04:07 AM, Sylwester Nawrocki wrote:
> Hi Kishon,
>
> On 04/29/2013 12:03 PM, Kishon Vijay Abraham I wrote:
>> The PHY framework provides a set of APIs for the PHY drivers to
>> create/destroy a PHY and APIs for the PHY users to obtain a reference
>> to the
>> PHY with or without using phandle. For dt-boot, the PHY drivers should
>> also register *PHY provider* with the framework.
>>
>> PHY drivers should create the PHY by passing id and ops like init, exit,
>> power_on and power_off. This framework is also pm runtime enabled.
>>
>> The documentation for the generic PHY framework is added in
>> Documentation/phy.txt and the documentation for dt binding can be
>> found at
>> Documentation/devicetree/bindings/phy/phy-bindings.txt
>>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>
> Thanks for working on this. For the record, I plan to give this a try
> in the end of this week, with my simple MIPI CSI/DSI PHY driver. I might
> have some more comments then. For now just couple of remarks after
> reading the documentation.

Thanks for reviewing. I'll wait for your comments before posting the 
next version.

Thanks
Kishon

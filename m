From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 19 Jan 2018 14:16:09 -0800
Subject: [PATCH v5 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
In-Reply-To: <2315959.AJds7mCBWN@ice-x220i>
References: <1515639823-35782-1-git-send-email-yong.deng@magewell.com>
 <20180119211409.ubysuyvhkmfotbdg@rob-hp-laptop>
 <2315959.AJds7mCBWN@ice-x220i>
Message-ID: <2134527e-cb44-1c4d-0ac9-8bbfc71b8ce8@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2018 01:17 PM, Icenowy Zheng wrote:
> ? 2018?1?20???? CST ??5:14:09?Rob Herring ???
>> On Thu, Jan 11, 2018 at 11:03:43AM +0800, Yong Deng wrote:
>>> Add binding documentation for Allwinner V3s CSI.
>>>
>>> Signed-off-by: Yong Deng <yong.deng@magewell.com>
>>> ---
>>>
>>>  .../devicetree/bindings/media/sun6i-csi.txt        | 59
>>>  ++++++++++++++++++++++ 1 file changed, 59 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> I think other subsystem's maintainer may expect a Acked-by from you here.
> 
> Why do you use Reviewed-by here instead?

The Reviewed-by: tag is a stronger ACK than the Acked-by: tag, so this
should be sufficient for other subsystem maintainers.

Please see Documentation/process/submitting-patches.rst, section 13.


-- 
~Randy

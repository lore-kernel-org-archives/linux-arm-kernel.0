From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 03:26:20 -0500
Subject: [PATCH v2 1/2] clk/zynq/clkc: Add 'fclk-enable' feature
In-Reply-To: <2028580.HhySWWnU2A@flatron>
References: <1381425018-5653-1-git-send-email-soren.brinkmann@xilinx.com>
 <1592656.1ojHcSlzVh@flatron>
 <b7840a0d-ac49-4c2d-beaa-9f79748c70d0@CH1EHSMHS006.ehs.local>
 <2028580.HhySWWnU2A@flatron>
Message-ID: <8864256B-F8F9-4474-9B5F-416C3BB96523@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 28, 2013, at 5:17 PM, Tomasz Figa wrote:

>>>> diff --git a/Documentation/devicetree/bindings/clock/zynq-7000.txt
>>>> b/Documentation/devicetree/bindings/clock/zynq-7000.txt index
>>>> d99af878f5d7..11fdd146ec83 100644
>>>> --- a/Documentation/devicetree/bindings/clock/zynq-7000.txt
>>>> +++ b/Documentation/devicetree/bindings/clock/zynq-7000.txt
>>>> 
>>>> @@ -22,6 +22,10 @@ Required properties:
>>>> Optional properties:
>>>>  - clocks : as described in the clock bindings
>>>>  - clock-names : as described in the clock bindings
>>>> 
>>>> + - fclk-enable : Bit mask to enable FCLKs in cases no proper CCF
>>> 
>>> Since it's a vendor specific property, it should include vendor
>>> prefix.
>> 
>> The whole driver is vendor specific. Should there really be another
>> prefix for that property?
> 
> Yes. If a property is introduced just for use by this particular driver 
> then it must be prepended by a vendor prefix. That's a general rule.

Most all nodes are vendor specific by definition ;).

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

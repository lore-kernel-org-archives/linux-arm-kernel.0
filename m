From: hanjie.lin@amlogic.com (Hanjie Lin)
Date: Thu, 30 Aug 2018 15:50:19 +0800
Subject: [PATCH v2 1/2] dt-bindings: phy: add DT bindings for Amlogic
 Meson PCIe Phy controller
In-Reply-To: <20180829003722.GA25763@bogus>
References: <1535096006-152091-1-git-send-email-hanjie.lin@amlogic.com>
 <1535096006-152091-2-git-send-email-hanjie.lin@amlogic.com>
 <20180829003722.GA25763@bogus>
Message-ID: <82b460e6-0cfe-b5c4-f4ed-d339c579453e@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/8/29 8:37, Rob Herring wrote:
> On Fri, 24 Aug 2018 15:33:25 +0800, Hanjie Lin wrote:
>> From: Yue Wang <yue.wang@amlogic.com>
>>
>> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
>> of the PCI Express Gen 2 specification and is backward compatible
>> with the 2.5-Gbps Gen 1.1 specification with only
>> inferred idle detection supported on Amlogic SoCs.
>>
>> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
>> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
>> ---
>>  .../bindings/phy/amlogic,meson-pcie-phy.txt         | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
>>
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> .
> 

Thanks for the review.

As described during the discussion [0], we consider it's too overkill to
have a dedicated phy driver which only process reset line. So we will abandon phy driver 
and integrate phy reset into the controller driver int the next version. 

[0] https://lkml.kernel.org/r/1535096165-45827-1-git-send-email-hanjie.lin at amlogic.

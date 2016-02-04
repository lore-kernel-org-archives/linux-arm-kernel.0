From: yang.shi@linaro.org (Shi, Yang)
Date: Thu, 4 Feb 2016 15:49:26 -0800
Subject: [PATCH] PCI: layerscape: add ls2085a compatible
In-Reply-To: <20160204223711.GE7031@localhost>
References: <1453915925-19198-1-git-send-email-yang.shi@linaro.org>
 <56A906F4.3050809@linaro.org> <20160204223711.GE7031@localhost>
Message-ID: <56B3E386.8010002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/4/2016 2:37 PM, Bjorn Helgaas wrote:
> On Wed, Jan 27, 2016 at 10:05:40AM -0800, Shi, Yang wrote:
>> Correct FSL folks email address to nxp.com, sorry for the inconvenience.
>
> Do we need some MAINTAINERS updates in addition to the ack for this patch?
> I see a bunch of @freescale.com addresses in MAINTAINERS.

I guess so if the @freescale.com address is not valid anymore.

Thanks,
Yang

>
>> On 1/27/2016 9:32 AM, Yang Shi wrote:
>>> The layerscape PCI host driver needs recognize ls2085a compatible when using
>>> firmware with ls2085a compatible property, otherwise the PCI bus won't be
>>> detected even though ls2085a compatible is included by the dts.
>>>
>>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>>> ---
>>>   drivers/pci/host/pci-layerscape.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
>>> index 3923bed..c40d8b2 100644
>>> --- a/drivers/pci/host/pci-layerscape.c
>>> +++ b/drivers/pci/host/pci-layerscape.c
>>> @@ -203,6 +203,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
>>>   	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
>>>   	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
>>>   	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
>>> +	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
>>>   	{ },
>>>   };
>>>   MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
>>>
>>

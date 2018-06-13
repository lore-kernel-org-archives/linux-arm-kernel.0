From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 13 Jun 2018 16:33:57 -0700
Subject: [PATCH 2/5] ARM: dts: cygnus: Fix PCIe controller interrupt type
In-Reply-To: <99e3ab78-a639-5244-75a6-af39e56e7c67@gmail.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
 <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
 <99e3ab78-a639-5244-75a6-af39e56e7c67@gmail.com>
Message-ID: <3e7c0673-0053-ed47-32e5-c972e308508d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/13/2018 12:50 PM, Florian Fainelli wrote:
> On 06/12/2018 01:21 PM, Ray Jui wrote:
>> Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
>> Cygnus SoC
>>
>> Fixes: cd590b50a936 ("ARM: dts: enable PCIe support for Cygnus")
> 
> This one is valid
> 
>> Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
>> bus")
>> Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
>> Fixes: f6b889358a82 ("ARM: dts: Enable MSI support for Broadcom Cygnus")
> 
> And this one too, but the two others, I would probably drop them so we
> can get the backports to be possibly applicable as far as when these two
> commits can be resolved, does that work?
> 

Yah that will work. Will make the change. Thanks.

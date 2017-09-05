From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 5 Sep 2017 11:41:47 +0530
Subject: [PATCH V5 0/4] Add Broadcom STB USB phy driver
In-Reply-To: <f4625f5e-db00-ebcc-4618-6f00247edfab@gmail.com>
References: <1503683495-11766-1-git-send-email-alcooperx@gmail.com>
 <f4625f5e-db00-ebcc-4618-6f00247edfab@gmail.com>
Message-ID: <f7bb89bf-1a09-891c-4ae5-3dc2e4b38d97@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian,

On Saturday 02 September 2017 07:46 AM, Florian Fainelli wrote:
> 
> 
> On 08/25/2017 10:51 AM, Al Cooper wrote:
>> Add a new USB Phy driver for Broadcom STB SoCs. This driver
>> supports Broadcom STB ARM SoCs. This driver in
>> combination with the Broadcom STB ohci, ehci and xhci
>> drivers will enable USB1.1, USB2.0 and USB3.0 support.
>> This Phy driver also supports the Broadcom BDC gadget
>> driver.
> 
> Thanks Al! Kishon, feel free to merge everything through your tree there
> should not be any conflicts with drivers/soc/bcm/brcmstb/common.c and
> include/linux/soc/brcmstb/brcmstb.h.

I'll start merging once 4.14 -rc1 is tagged.

Thanks
Kishon

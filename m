From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2016 16:16:41 +0530
Subject: [PATCH v4 4/4] ARM: dts: da850: Add the usb otg device node
In-Reply-To: <4fa9243a-47ec-80a7-bb79-fa65b4fc4d4a@lechnology.com>
References: <1478188752-22447-1-git-send-email-abailon@baylibre.com>
 <1478188752-22447-5-git-send-email-abailon@baylibre.com>
 <4fa9243a-47ec-80a7-bb79-fa65b4fc4d4a@lechnology.com>
Message-ID: <455bdff2-e6ab-0bba-9f5b-d5239803ffc3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 November 2016 09:10 AM, David Lechner wrote:
> 
>> +        usb0: usb at 200000 {
>> +            compatible = "ti,da830-musb";
>> +            reg = <0x200000 0x10000>;
>> +            interrupts = <58>;
>> +            interrupt-names = "mc";
>> +            dr_mode = "otg";
> 
> Isn't this the default value? Could we omit the dr_mode property here?

dr_mode is set to otg in quite a few dts files already. Even if its the
default, I think it makes it easy to recognize the mode immediately.

Thanks,
Sekhar

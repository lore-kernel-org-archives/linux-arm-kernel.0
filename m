From: rogerq@ti.com (Roger Quadros)
Date: Mon, 14 Jan 2013 11:48:45 +0200
Subject: [PATCH 07/14] usb: ehci-omap: Instantiate PHY devices if required
In-Reply-To: <20130111163255.GF23505@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.44L0.1301111019340.1730-100000@iolanthe.rowland.org>
 <50F037C9.40306@ti.com> <20130111163255.GF23505@n2100.arm.linux.org.uk>
Message-ID: <50F3D47D.1020103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2013 06:32 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 11, 2013 at 06:03:21PM +0200, Roger Quadros wrote:
>> diff --git a/include/linux/platform_data/usb-omap.h
>> b/include/linux/platform_data/usb-omap.h
>> index d63eb7d..927b8a1 100644
>> --- a/include/linux/platform_data/usb-omap.h
>> +++ b/include/linux/platform_data/usb-omap.h
>> @@ -38,6 +38,12 @@ enum usbhs_omap_port_mode {
>>  	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM
>>  };
>>
>> +struct usbhs_phy_config {
>> +	char *name;		/* binds to device driver */
> 
> You may wish to consider making this const.
> 
OK.

--
cheers,
-roger

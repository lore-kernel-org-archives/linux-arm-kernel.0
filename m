From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Mon, 7 Sep 2009 12:20:06 +0200
Subject: Patches for Freescale MXC SoCs and direct ULPI communication [v3]
In-Reply-To: <4A9FE3C6.3050609@epfl.ch>
References: <1251924478-30651-1-git-send-email-daniel@caiaq.de>
	<4A9FE3C6.3050609@epfl.ch>
Message-ID: <20090907102006.GB31592@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Back from holiday...

On Thu, Sep 03, 2009 at 05:41:58PM +0200, Valentin Longchamp wrote:
> Hi Daniel,
>
> Daniel Mack wrote:
>> Sorry for the long delay on this issue.
>>
>> Here comes another round of four patches to support the EHCI ports on
>> Freescale's MX2/MX3 SoCs.
>>
>> The difference to the last version I've sent is that the ISP1504
>> specific drivers has become a generic ULPI driver now with all the
>> defines renamed.
>>
>> Also the driver does not set DRV_VBUS and DRV_VBUS_EXT blindly
>> anymore but uses a flags field in the otg_transceiver struct which can
>> be specified when creating the device. This allows the adaption of the
>> code to a wider variety of applications.
>>
>> As a reference, I've added a patch to add board specific support code
>> for the lilly1131 module.
>
> I have such a patch for mx31moboard too. Sascha, should I send it to you  
> now or wait ?

Please wait till it's clear that the patches go in the way they are,
otherwise I end up keeping patches that still need fixups.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

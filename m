From: cb@sgoc.de (Christoph)
Date: Thu, 18 Apr 2013 15:17:09 +0200 (CEST)
Subject: =?UTF-8?Q?Patch_for_Crypto-Cop=E2=80=8Brocesor?=
 =?UTF-8?Q?_(DCP)_on_Freescale=E2=80=8B_i.MX28=E2=80=8B?=
Message-ID: <1368909273.384531.1366291029932.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

maybe some know that Freescale released a SDK for the i.MX28 SoC based on Linux
2.6.35.3 with a plethora of patches.
Most features made it to more recent kernels. So I switched development to the
then recent 3.7.
One thing I missed in 3.7 was support for the Crypto-Coprocessor (DCP). So I
ported the driver from Freescale to 3.7. The patch here
http://www.sgoc.de/Downloads/fsl-dcp.patch should also be applicable on recent
versions like 3.9.

I hope this is the right place to share this.



Regards,
Christoph Bauman

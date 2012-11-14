From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 14 Nov 2012 09:39:19 +0200
Subject: [PATCH 1/6] ARM/dts: omap4-panda: Add pinmux configuration for
 HDMI
In-Reply-To: <50A29B12.9030906@ti.com>
References: <1352121259-5836-1-git-send-email-tomi.valkeinen@ti.com>
 <1352121259-5836-2-git-send-email-tomi.valkeinen@ti.com>
 <50A29B12.9030906@ti.com>
Message-ID: <50A34AA7.8060700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2012-11-13 21:10, Ricardo Neri wrote:
> Hi Tomi,
> 
> On 11/05/2012 07:14 AM, Tomi Valkeinen wrote:
>> From: Ricardo Neri <ricardo.neri@ti.com>
>>
>> Add the pinmux configuration for HDMI and TPD12S015A. Configure the
>> gpios for the TPD12S015A and SDA, SCL and CEC for HDMI.
> 
> Do you plan to upstream the complete DT-boot support for DSS
> (specifically, HDMI) for 3.8? I am asking so that I can upstream the
> audio part.

No. This series will enable DSS with DT boot on panda and sdp boards,
but it's achieved by a hack, as the DSS configuration still comes from
platform data.

To get full DSS DT support we need to pretty much rewrite the dss panel
device handling and adapt to common panel framework (which isn't ready yet).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/4f5e5a1a/attachment.sig>

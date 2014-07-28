From: stwiss.opensource@diasemi.com (Opensource [Steve Twiss])
Date: Mon, 28 Jul 2014 09:53:56 +0000
Subject: [RESEND RFC V2] devicetree: Dialog Semiconductor consolidate
 existing vendor prefixes to standardise on 'dlg'
In-Reply-To: <20140725070002.GH7063@lee--X1>
References: <201407241554.s6OFsqbW031651@swsrvapps-01.diasemi.com>
 <20140725070002.GH7063@lee--X1>
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7D0B28E95@SW-EX-MBX02.diasemi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 July 2014 08:00, Lee Jones wrote:

>On Thu, 24 Jul 2014, Opensource [Steve Twiss] wrote:
>> From: Steve Twiss <stwiss.opensource@diasemi.com>
>>
>> This patch series updates the device tree vendor prefix for
>> Dialog Semiconductor.
>>
>> Various methods are currently used throughout the kernel: 'diasemi',
>> 'dialog' and 'dlg'. Others have also been suggested.
>>
>> This patch set aims to consolidate the usage of the vendor prefix to
>> use a common standard. The prefix 'dlg' is used.
>>
>>
>> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>
>Didn't I Ack the MFD parts already?
>

Yes -- certainly.
 (I should have put them in the main body of the e-mail shouldn't I ..?)

I just need the SHMobile responses now.
I will try to make contact with those guys this week.

I have the following Acks so far.

>From: Rob Herring on 21 July 2014 16:43
>I'm okay with this, but it also needs acks from i.MX and SHMobile
>folks as it could break out of tree users.
>  Acked-by: Rob Herring <robh@kernel.org>

>From: Shawn Guo on 22 July 2014 02:38
>arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
>arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-
>  Acked-by: Shawn Guo <shawn.guo@freescale.com>

>From: Lee Jones on 22 July 2014 08:09
>For the MFD changes:
>  Acked-by: Lee Jones <lee.jones@linaro.org>

and

>From: Philipp Zabel on 24 July 2014 20:44
>  Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Regards,
Steve

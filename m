From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Wed, 03 Dec 2014 07:37:13 -0700
Subject: [PATCH 0/3 RESEND] ARM: dts: sabrelite I2C and HDMI additions
In-Reply-To: <CADCpmyN8J0XdUShLZwxny=DoJvpmNGjhNQCuOMZ64ac_VTP7BQ@mail.gmail.com>
References: <1417559839-17365-1-git-send-email-eric.nelson@boundarydevices.com>
 <CADCpmyN8J0XdUShLZwxny=DoJvpmNGjhNQCuOMZ64ac_VTP7BQ@mail.gmail.com>
Message-ID: <547F2019.5060101@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On 12/02/2014 10:04 PM, Gary Bisson wrote:
> Eric, All,
> 
> On Tue, Dec 2, 2014 at 2:37 PM, Eric Nelson
> <eric.nelson@boundarydevices.com> wrote:
>> This set of patches adds support for I2C2/3 busses and HDMI output
>> for the SABRE Lite board.
>>
>> The content was gratuitously copied from the following commits
>> for the Nitrogen6X board made by Lucas Stach, Michael Olbrich,
>> and Philipp Zabel at Pengutronix:
>>
>>         43c3c00 - ARM: dts: nitrogen6x: add i2c2
>>         d653620 - ARM: dts: nitrogen6x: add hdmi
>>         1dffdd6 - ARM: dts: nitrogen6x: add i2c3
>>
>> Eric Nelson (3):
>>   ARM: dts: sabrelite: add i2c2
>>   ARM: dts: sabrelite: add hdmi
>>   ARM: dts: sabrelite: add i2c3
>>
>>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 33 ++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> Re-sending to add Shawn Guo to the CC list.
>>
>> --
>> 1.9.1
>>
> 
> Tested on a SabreLite (iMX6q rev1.2), it works great once the ldb node
> is removed from imx6qdl-sabrelite.dtsi.
> It is to be noted that I've applied the patches on top of the
> linux-stable tree. Eric, are you using Shawn's tree? I'll try with
> that latter to see if I can keep both ldb and hdmi nodes at the same
> time.
> 
The patches were generated based on Shawn's imx/dt branch, but I
also tested against linux-stable.

I didn't need to remove the LDB node in either case. HDMI just
worked.

Regards,


Eric

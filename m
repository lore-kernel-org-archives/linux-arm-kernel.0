From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Sat, 2 Apr 2016 18:08:51 +0200
Subject: [PATCH v2 1/9] ARM: dts: imx7d: add lcdif support
In-Reply-To: <20160402012955.GI18833@tiger>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458050668-26748-2-git-send-email-gary.bisson@boundarydevices.com>
 <20160402012955.GI18833@tiger>
Message-ID: <CAAMH-yt3gNcb57asbos7D=Kb8Z+bnNmYOF7qqu+dDho6HCDb4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn, All,

On Sat, Apr 2, 2016 at 3:29 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Tue, Mar 15, 2016 at 03:04:20PM +0100, Gary Bisson wrote:
>> Add the device node for the i.MX7 eLCDIF interface.
>>
>> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
>> ---
>>
>> Changelog v1 -> v2:
>> - none
>>
>> ---
>>  arch/arm/boot/dts/imx7d.dtsi | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
>> index b5a50e0..a768716 100644
>> --- a/arch/arm/boot/dts/imx7d.dtsi
>> +++ b/arch/arm/boot/dts/imx7d.dtsi
>> @@ -608,6 +608,17 @@
>>                               status = "disabled";
>>                       };
>>
>> +                     lcdif: lcdif at 30730000 {
>
> Please add the node in order of unit-address.

Sorry I did it alphabetically for some reason, I'll submit a v3 today.

Regards,
Gary

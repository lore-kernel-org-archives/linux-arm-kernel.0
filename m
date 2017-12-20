From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:51:34 +1030
Subject: [PATCH v2 10/19] ARM: dts: aspeed: Add LPC Snoop device
In-Reply-To: <c5ef27de-34c1-f5e9-e4ae-e2709b004677@kaod.org>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-11-joel@jms.id.au>
 <c5ef27de-34c1-f5e9-e4ae-e2709b004677@kaod.org>
Message-ID: <CACPK8Xd2e=wDD7udyH9-mMuxXsRjCj8LDsosp=5b3e0iTJwA5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 18, 2017 at 7:46 PM, C?dric Le Goater <clg@kaod.org> wrote:
> On 12/15/2017 07:24 AM, Joel Stanley wrote:
>> LPC snoop hardware on the ASPEED BMC, used for monitoring
>> host I/O port activity.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
>>  arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
>> index f6fee40c04c0..b3580f37f507 100644
>> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
>> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
>> @@ -236,6 +236,13 @@
>>                                               status = "disabled";
>>                                       };
>>
>> +                                     lpc_snoop: lpc-snoop at 0 {
>> +                                             compatible = "aspeed,ast2500-lpc-snoop";
>
> it should be :
>
>         aspeed,ast2400-lpc-snoop
>
> a part from that :
>
> Reviewed-by: C?dric Le Goater <clg@kaod.org>

Fixed in v3.

Cheers,

Joel

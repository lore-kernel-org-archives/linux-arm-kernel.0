From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Mar 2016 12:03:09 +0200
Subject: [PATCH v2] ARM: mvebu: Correct unit address for linksys
In-Reply-To: <op.ye4rjnln2s3iss@ecaz> (Imre Kaloz's message of "Wed, 30 Mar
 2016 11:05:37 +0200")
References: <1459270660-30411-1-git-send-email-patrick@puiterwijk.org>
 <op.ye4rjnln2s3iss@ecaz>
Message-ID: <877fgkuvtu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrick,
 
 On mer., mars 30 2016, "Imre Kaloz" <kaloz@openwrt.org> wrote:

> Right, a165c3b63b6f24fdc47c270db5f8b1a48b69c1b6 was merged sooner then
> this board setup file.
>
> Acked-by: Imre Kaloz <kaloz@openwrt.org>

Applied on mvebu/fixes. I also added the following flags to the commit:
Cc: <stable@vger.kernel.org>
Fixes: 2d0a7addbd10 ("ARM: Kirkwood: Add support for many Synology NAS devices")

as well as the acked-by from Imre.

Thanks,

Gregory
>
> On Tue, 29 Mar 2016 18:57:40 +0200, Patrick Uiterwijk
> <patrick@puiterwijk.org> wrote:
>
>> The USB2 port for Armada 38x is defined to be at 58000, not at
>> 50000.
>>
>> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
>> ---
>>  arch/arm/boot/dts/armada-385-linksys.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi
>> b/arch/arm/boot/dts/armada-385-linksys.dtsi
>> index 3710755..85d2c37 100644
>> --- a/arch/arm/boot/dts/armada-385-linksys.dtsi
>> +++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
>> @@ -117,7 +117,7 @@
>>  			};
>> 			/* USB part of the eSATA/USB 2.0 port */
>> -			usb at 50000 {
>> +			usb at 58000 {
>>  				status = "okay";
>>  			};

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

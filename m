From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Mon, 18 May 2015 07:12:29 -0700
Subject: [PATCH 1/2] ARM: dts: nitrogen6x: use simple-panel instead of
 display-timings for LVDS0
In-Reply-To: <20150518075844.7e1b5916@ipc1.ka-ro>
References: <1431804202-11067-1-git-send-email-eric.nelson@boundarydevices.com>	<1431804202-11067-2-git-send-email-eric.nelson@boundarydevices.com>
 <20150518075844.7e1b5916@ipc1.ka-ro>
Message-ID: <5559F34D.5090308@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2015 10:58 PM, Lothar Wa?mann wrote:
> Hi,
> 
>> Also add alias for backlight_lvds and connect it to the display.
>>
>> Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 30 +++++++++++++++++-------------
>>  1 file changed, 17 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
>> index fd096dc..712c5ec 100644
>> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
>> @@ -122,7 +122,7 @@
>>  		status = "okay";
>>  	};
>>  
>> -	backlight_lvds {
>> +	backlight_lvds: backlight_lvds {
>>
> The patch does not add an 'alias', but a 'label'.
> 

Good catch.

Thanks for the clarification.

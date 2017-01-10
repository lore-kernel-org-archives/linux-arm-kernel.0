From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 10 Jan 2017 16:03:53 -0300
Subject: [PATCH v2 3/3] arm64: dts: exynos: Remove unneeded unit names in
 Exynos5433 nodes
In-Reply-To: <20170110185109.n3x25yxbaarzikcd@kozik-lap>
References: <1484069912-6534-1-git-send-email-javier@osg.samsung.com>
 <1484069912-6534-4-git-send-email-javier@osg.samsung.com>
 <20170110185109.n3x25yxbaarzikcd@kozik-lap>
Message-ID: <9ee4d297-51fd-fd37-e4e4-1a939a644201@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/10/2017 03:51 PM, Krzysztof Kozlowski wrote:

[snip]

>>  
>> -		usbdrd30: usb at 15400000  {
>> +		usbdrd30: usb-0  {
> 
> How about "usbdrd" instead of "usb-0"? It would be still quite a generic
> description of a class.
> 
>>  			compatible = "samsung,exynos5250-dwusb3";
>>  			clocks = <&cmu_fsys CLK_ACLK_USBDRD30>,
>>  				<&cmu_fsys CLK_SCLK_USBDRD30>;
>> @@ -1332,7 +1332,7 @@
>>  			status = "disabled";
>>  		};
>>  
>> -		usbhost30: usb at 15a00000 {
>> +		usbhost30: usb-1 {
> 
> usbhost?
> 

Indeed, these sounds better so I'll change for them.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

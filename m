From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 20 Aug 2014 12:27:53 +0200
Subject: [PATCH 1/6] ARM: dts: Add Peach Pit and Pi dts entry for max77802
 PMIC
In-Reply-To: <53F39CE3.8040303@suse.de>
References: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408460913-13863-2-git-send-email-javier.martinez@collabora.co.uk>
 <53F39CE3.8040303@suse.de>
Message-ID: <53F47829.5040708@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 08/19/2014 08:52 PM, Andreas F?rber wrote:
>> +
>> +	max77802-pmic at 9 {
>> +		compatible = "maxim,max77802";
>> +		interrupt-parent = <&gpx3>;
>> +		interrupts = <1 0>;
> 
> <1 IRQ_TYPE_NONE>?
> 

Indeed, I'll change both on v2. Thanks a lot.

> 
> Cheers,
> Andreas
> 

Best regards,
Javier

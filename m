From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 01 Aug 2014 05:17:42 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA936E.9060004@gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com>
Message-ID: <53DB06D6.9060604@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.07.2014 21:05, schrieb Tomasz Figa:
>> +
>> +&i2c_2 {
>> +	status = "okay";
>> +	samsung,i2c-sda-delay = <100>;
>> +	samsung,i2c-max-bus-freq = <66000>;
>> +
>> +	hdmiddc at 50 {
>> +		compatible = "samsung,exynos4210-hdmiddc";
>> +		reg = <0x50>;
>> +	};
> 
> I don't think this matches current Exynos HDMI bindings, which I believe
> have been changed to just take a phandle to i2c bus instead.

Looks correct to me:

http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/tree/Documentation/devicetree/bindings/video/exynos_hdmiddc.txt?h=for-next

https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/video/exynos_hdmiddc.txt

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

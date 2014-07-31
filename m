From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Thu, 31 Jul 2014 22:36:54 +0200
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA936E.9060004@gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com>
Message-ID: <53DAA8E6.3010400@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 31.07.2014 21:05, schrieb Tomasz Figa:
>> +	};
>> +
>> +	fixed-rate-clocks {
>> +		xxti {
>> +			compatible = "samsung,clock-xxti";
>> +			clock-frequency = <24000000>;
>> +		};
>> +	};
> 
> This is also referencing a node from higher level, so it should be done
> using a reference.

Actually this one isn't! Neither fixed-rate-clocks nor xxti exists in
the .dtsi.

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

From: jgq516@gmail.com (Xiao Jiang)
Date: Wed, 30 May 2012 18:31:10 +0800
Subject: [PATCH 3/3] watchdog: omap_wdt: add device tree support
In-Reply-To: <4FC5F2FA.4050606@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com>
 <1337942552-28218-4-git-send-email-jgq516@gmail.com>
 <4FC51008.1050004@ti.com> <4FC59171.8040009@gmail.com>
 <4FC5D21F.2030702@ti.com> <4FC5F2FA.4050606@gmail.com>
Message-ID: <4FC5F6EE.1020905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>> If there is no difference between the OMAP3 and the OMAP4 WDT IP, 
>> just add one entry "ti,omap3-wdt". And then in the OMAP4 DTS you will 
>> just put : compatible = "ti,omap3-wdt"; or compatible =  
>> "ti,omap4-wdt", "ti,omap3-wdt";
>> I'm still a little bit confused about the real need for the 
>> "ti,omap4-wdt: entry, but it seems to be the way to do it in PPC.
> I believe OMAP2, OMAP3 and OMAP4 share the same IP, so how about use 
> "ti, omap2-wdt"? and other dts files
> put compatible like "ti,omap4-wdt", "ti,omap2-wdt" and "ti,omap4-wdt", 
> "ti,omap2-wdt".
>
Typo, should be "ti,omap3-wdt", "ti,omap2-wdt" and "ti,omap4-wdt", 
"ti,omap2-wdt".

Regards,
Xiao

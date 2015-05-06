From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 06 May 2015 21:22:38 +0200
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <d97c3a8a29aa85c83973daf4a22ca4c9@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <20150506095312.GU4276@piout.net> <d97c3a8a29aa85c83973daf4a22ca4c9@advem.lv>
Message-ID: <2349062.9v3Zz7HPLu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 19:21:21 Roman Yeryomin wrote:
> 
> > Thanks to point that, I'll merge that one which seems clean enough:
> > http://git.openwrt.org/?p=openwrt.git;a=blob;f=target/linux/gemini/files/drivers/rtc/rtc-gemini.c;h=587d8122b2fbb1230437eadcce4789a53aa60ee5;hb=4c637410a2a1ab45988e8ca6202554a502102039
> 
> For 3.18 (and up) to work on gemini 160-gemini-timers.patch is vital. 
> Without that timers are broken and cpu is super slow.

Do you know what part of the patch is the actual bug fix? We should probably
merge that separately and mark it for stable backports, while the bulk of that
patch seems to just rearrange code.

	Arnd

From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 01 Sep 2011 11:34:17 +0100
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>	<1314804471.2344.79.camel@deneb.redhat.com>	<4E5E5D80.6080409@arm.com>
	<201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
Message-ID: <4E5F5FA9.3010305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 31/08/11 17:55, Marc Dietrich wrote:
> Am Mittwoch 31 August 2011, 18:12:48 schrieb Marc Zyngier:
>> [...]
>> Oddly enough, this patch doesn't do anything on my Tegra setup. In both
>> cases, I get around 17MB/s from a crap SD card plugged in a USB reader.
>>
>> This leads me to suspect that this issue is very much OMAP4 specific.
>> Can anyone verify this theory on other some A9 platforms?
> 
> That's odd. On my Tegra2 (on ac100) it boosts the transfer rate from 7 to 
> 17 MB/s. 

I'm using a Harmony board. Could you share your kernel version, .config
and dmesg?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

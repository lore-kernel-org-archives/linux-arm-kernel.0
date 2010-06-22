From: pieterg@gmx.com (pieterg)
Date: Tue, 22 Jun 2010 10:06:20 +0200
Subject: [PATCH] pxa3xx: Fix HSIO bus x24 multiplier
In-Reply-To: <1277154123-31532-1-git-send-email-marek.vasut@gmail.com>
References: <1277154123-31532-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201006221006.20590.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 June 2010 23:02:03 Marek Vasut wrote:
> The value should be 24, not 0 in the possibilities array. It was just a
> silly mistake.

Good one, reminds me that I've had this one on my list as well for a while. 
I actually went one step further, made the pxa310 use HSIO 312MHz when 
running on 624MHz.

(not sure whether the patch will apply cleanly, but cpufreq-pxa3xx.c still 
looks roughly the same at first glance..)

Rgds, Pieter
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-cpufreq-pxa3xx-use-a-default-HSIO-bus-clock-speed-of.patch
Type: text/x-diff
Size: 1832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100622/587105ee/attachment.bin>

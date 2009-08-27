From: bgat@billgatliff.com (Bill Gatliff)
Date: Thu, 27 Aug 2009 15:31:46 -0500
Subject: [PATCH] watchdog: Add support for the Avionic Design Xanthos
	watchdog timer.
In-Reply-To: <20090827202314.GJ29382@infomag.iguana.be>
References: <20090821073105.GC29382@infomag.iguana.be>	<1250860202-28187-1-git-send-email-thierry.reding@avionic-design.de>	<20090822081806.GD29382@infomag.iguana.be>	<20090824090407.GA24894@avionic-design.de>
	<20090827202314.GJ29382@infomag.iguana.be>
Message-ID: <4A96ED32.7000108@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wim Van Sebroeck wrote:
> This is the only thing I'm still struggling with: the goal of a watchdog device driver is to make sure that the system reboots when the system isn't stable anymore. So why should you then trigger the interrupt?
>   

... because a hard reboot might not be the way he wants to resolve the 
situation.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com

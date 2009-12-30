From: me@felipebalbi.com (Felipe Balbi)
Date: Wed, 30 Dec 2009 13:53:32 +0200
Subject: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk
	handling
In-Reply-To: <4B3B3720.9070205@ru.mvista.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
	<1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
	<4B3B3720.9070205@ru.mvista.com>
Message-ID: <1262174012.28789.178.camel@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, 2009-12-30 at 14:18 +0300, Sergei Shtylyov wrote:
>    Why always "ick"?! Do you think OMAPs are the only boards using MUSB 
> out there?

err, I'm afraid you have to read more about clock framework. The clock
name should not matter when you issue clk_get(). I used the shortest
name that came to my mind. could've been "usb", "usb_clock",
"musb_otg_default_clock". It doesn't matter.


-- 
balbi

From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Feb 2017 08:23:16 -0800
Subject: ARM: OMAP2+: Grab reference to device nodes where needed
In-Reply-To: <20170227233405.GA16546@roeck-us.net>
References: <1486853948-20978-1-git-send-email-linux@roeck-us.net>
 <20170227233405.GA16546@roeck-us.net>
Message-ID: <20170228162315.GS21809@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Guenter Roeck <linux@roeck-us.net> [170227 15:36]:
> ping ... this problem is now seen in mainline.

Oops sorry I had accidentally tagged this with "next" instead of
"fixes".

Looking at the patch though, can't we make of_node_get/put local to
omap3xxx_hwmod_is_hs_ip_block_usable()?

Regards,

Tony

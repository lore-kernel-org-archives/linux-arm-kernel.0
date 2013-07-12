From: tony@atomide.com (Tony Lindgren)
Date: Fri, 12 Jul 2013 02:46:31 -0700
Subject: [PATCH 1/2] Revert "ARM: OMAP2+: Fix serial init for device
 tree based booting"
In-Reply-To: <51DFCAF3.7040503@ti.com>
References: <1373539986-27272-1-git-send-email-rnayak@ti.com>
 <1373539986-27272-2-git-send-email-rnayak@ti.com>
 <20130712072051.GA7656@atomide.com> <51DFB0E4.6040007@ti.com>
 <20130712080305.GD7656@atomide.com> <51DFC58C.7030105@ti.com>
 <20130712091827.GH7656@atomide.com> <51DFCAF3.7040503@ti.com>
Message-ID: <20130712094631.GI7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130712 02:29]:
>
> Right, that seems much cleaner. I will send a patch out for it and get rid
> of all the cmdline parsing in serial.c

Oh that's right, then it should not be needed for legacy pdata based
booting either :)

Regards,

Tony

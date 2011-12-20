From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Dec 2011 12:57:06 -0800
Subject: [PATCH v2 1/7][RESEND] ARM: OMAP1: ams-delta: register latch
 dependent devices later
In-Reply-To: <201112202134.36802.jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <201112200028.32947.jkrzyszt@tis.icnet.pl>
 <20111220180610.GB24444@atomide.com>
 <201112202134.36802.jkrzyszt@tis.icnet.pl>
Message-ID: <20111220205706.GH17267@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111220 12:03]:
> On Tuesday 20 of December 2011 at 19:06:11, Tony Lindgren wrote:
> 
> > To deal with the init order issues, you can pass a set_power
> > function pointer in platform_data that the driver can use. Or
> > set up a fixed regulator for it.
> 
> I'm already working on the follow up patch series mentioned in the cover 
> letter, and yes, I'm using the fixed regulator. Be patient, please, as 
> my resources are somehow limited.

Yes, I understand. For this patch I'm fine with the late_initcall
changes Russell suggested, then the rest can be done in separate
patches later on.

Regards,

Tony

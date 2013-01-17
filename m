From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 17 Jan 2013 23:19:24 +0100
Subject: [PATCH] am33xx: cpsw: default to ethernet hwaddr from efuse if
 not defined in dt
In-Reply-To: <20130117174528.GM14149@atomide.com> (Tony Lindgren's message of
 "Thu, 17 Jan 2013 09:45:29 -0800")
References: <1358370073-32545-1-git-send-email-jacmet@sunsite.dk>
 <loom.20130117T105358-639@post.gmane.org>
 <87a9s7lq09.fsf@dell.be.48ers.dk> <20130117174528.GM14149@atomide.com>
Message-ID: <871udjlafn.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Tony" == Tony Lindgren <tony@atomide.com> writes:

Hi,

 >> The way I've handled it is similar to how it is done on atleast one
 >> other arm subarchicture, see
 >> arch/arm/mach-mxs/mach-mxs.c::update_fec_mac_prop()

 Tony> Cool this seems like the cleanest way to deal with it so far. Can
 Tony> you please resend with also linux-net and DT list Cc:d too?

 Tony> Also the arch_initcall should be omap_arch_initcall in linux next
 Tony> for consistency if we ever have SoC specific sections for those.

Sure, resent with the initcall change and netdev/devicetree-discuss added.

-- 
Bye, Peter Korsgaard

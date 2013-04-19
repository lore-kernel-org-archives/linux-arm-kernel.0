From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Apr 2013 13:42:15 -0700
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <5171A095.8010104@ti.com>
References: <5170B4C6.1030300@gmail.com> <20130419161257.GI10155@atomide.com>
 <517173C0.6010902@ti.com> <5171A095.8010104@ti.com>
Message-ID: <20130419204215.GV10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130419 12:57]:
> 
> Looks like if support for TI OMAP2/3/4/5 SOCs is enabled, but all
> of OMAP2/3/4/5/AM33XX devices are then disabled you will get the
> above errors.
> 
> I think that the error is misleading, because AFAICT it has nothing
> to do with dss-common.c. The errors are because files like
> clockdomain.c and powerdomain.c are not being compiled but
> omap_hwmod.c is. 

Yeah just posted an initial patch for that as a reply to
Arnd's comment, maybe give that a try to see if it still
has randconfig sized holes?

Regards,

Tony

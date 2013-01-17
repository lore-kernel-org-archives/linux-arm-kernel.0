From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Jan 2013 14:31:39 -0800
Subject: [PATCH v7 19/22] ARM: OMAP3: clock data: get rid of unused USB
 host clock aliases and dummies
In-Reply-To: <alpine.DEB.2.00.1301172228140.14118@utopia.booyaka.com>
References: <1358422231-24736-1-git-send-email-rogerq@ti.com>
 <1358422231-24736-20-git-send-email-rogerq@ti.com>
 <20130117170321.GJ14149@atomide.com>
 <alpine.DEB.2.00.1301171854280.14118@utopia.booyaka.com>
 <20130117210034.GA27671@arwen.pp.htv.fi>
 <alpine.DEB.2.00.1301172228140.14118@utopia.booyaka.com>
Message-ID: <20130117223138.GN14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130117 14:33]:
> On Thu, 17 Jan 2013, Felipe Balbi wrote:
> 
> > do you mean v3.9 ?
> 
> It sounds like the other patches need to be merged first before these 
> cleanups can be merged.  So rather than adding a merge order dependency 
> during 3.9, it seems best to queue the non-essential clock cleanup side 
> for 3.10.

How about let's do it in a late cleanup branch towards the end of the
v3.9 merge window?

Regards,

Tony

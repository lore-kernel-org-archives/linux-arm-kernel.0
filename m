From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Jun 2013 00:12:28 -0700
Subject: [PATCH] ARM: Make multi_v7_defconfig usable on hardware
In-Reply-To: <CAOesGMg2du8PsOGy1kdePT4vMsWie1N8hmjCxRqr-LS6RAC07g@mail.gmail.com>
References: <1372210565-22962-1-git-send-email-olof@lixom.net>
 <CAOesGMg2du8PsOGy1kdePT4vMsWie1N8hmjCxRqr-LS6RAC07g@mail.gmail.com>
Message-ID: <20130626071228.GR5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130625 18:44]:
> On Tue, Jun 25, 2013 at 6:36 PM, Olof Johansson <olof@lixom.net> wrote:
> 
> > +CONFIG_DEBUG_LL=y
> > +CONFIG_DEBUG_OMAP2PLUS_UART=y
> > +CONFIG_DEBUG_OMAP4UART3=y
> 
> Clearly not supposed to be there for the posted version, my bad --
> will take those out before committing.
> 
> (this will go on top of next/late, btw).
> 

Looks good to me without the DEBUG_LL stuff:

Acked-by: Tony Lindgren <tony@atomide.com>

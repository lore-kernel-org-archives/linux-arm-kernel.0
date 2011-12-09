From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 9 Dec 2011 19:40:47 +0100
Subject: [PATCH 3/3] ide/at91: use new introduce smc accessor
In-Reply-To: <4EE1EB9B.4080500@mvista.com>
References: <20111208150348.GD23884@game.jcrosoft.org>
 <1323357784-17555-3-git-send-email-plagnioj@jcrosoft.com>
 <4EE1EB9B.4080500@mvista.com>
Message-ID: <20111209184047.GQ23884@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:06 Fri 09 Dec     , Sergei Shtylyov wrote:
> Hello.
> 
> On 08-12-2011 19:23, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
>    Same comment about the subject.
> 
> >this will allow to use the pata_at91 on a single zImage
> 
>    s/pata_at91/at91_ide/
> 
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> >Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> >Cc: linux-ide at vger.kernel.org
> >---
> >Hi,
> 
> >	it's depends on other patch for AT91 can we apply via at91
> 
>    I'm afraid David won't accept this, as the IDE tree is frozen for
> anything but the fixes.
basicaly it's a fix on at91 not ide. we can not compile all at91 together because of the
at91_sys_read/write so I need to fix it on at91 this one of the place I need
to touch.

I'll not touch it otherwise

Best Regards,
J.

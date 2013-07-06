From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 6 Jul 2013 18:33:41 +0200
Subject: [PATCHv4 03/11] pci: remove ARCH_SUPPORTS_MSI kconfig option
In-Reply-To: <20130706161743.GM2569@titan.lakedaemon.net>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1372686136-1370-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo73iSBg+SYwZLea0qdXD1uVc3+Vacd8Tg4CU92vLG=2AQ@mail.gmail.com>
 <20130705234501.1341f52e@skate>
 <20130706135433.GL2569@titan.lakedaemon.net>
 <CAErSpo4uN2MifYHbFiUfQ+6TE-hBkbWYdnAvabj8jCTOd5g+1A@mail.gmail.com>
 <20130706161743.GM2569@titan.lakedaemon.net>
Message-ID: <20130706183341.379d2fea@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Sat, 6 Jul 2013 12:17:43 -0400, Jason Cooper wrote:

> > > If we end up handling this the same as the of/pci & mvebu-pcie series
> > > (whole series through mvebu -> arm-soc) I can have it up in -next within
> > > a few days of -rc1.  Just let me know.
> > 
> > That sounds fine with me.  I don't think it's worth trying to split
> > out the drivers/pci stuff and trying to coordinate it going through
> > different trees.
> 
> Ok, will do.
> 
> Thomas, I assume there will be one more version to address Bjorn's last
> comments?

Yes, indeed. I was waiting to see if Thierry Redding would give some
additional feedback on Bjorn's comment, but if he doesn't, I'll resend
an updated version, most likely next week.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

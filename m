From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 3 Jul 2014 18:06:23 +0200
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <20140703155240.GU5814@saruman.home>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
 <20140702190944.GA567@drone.musicnaut.iki.fi>
 <CAOCHtYgxMeA+Arfe40XeFDEKuCJ8qo1RqNR0hYBGr_Wp6sRfdA@mail.gmail.com>
 <20140703073411.GX28884@atomide.com>
 <20140703132509.GA5814@saruman.home>
 <CAOCHtYi0JwRO12gHa+KFGH1k7pPk4TL40igwhzRRxutw-tqf6A@mail.gmail.com>
 <20140703140736.GF5814@saruman.home>
 <20140703154425.GC23309@earth.universe>
 <20140703155240.GU5814@saruman.home>
Message-ID: <20140703160622.GE23309@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 03, 2014 at 10:52:40AM -0500, Felipe Balbi wrote:
> > DT is supposed to contain information about the hardware, so it
> > should stay the same? I think there is no non-hackish way to decide
> 
> compatible would change, at a minimum.

why? I would expect it to stay the same (and the current patch uses
the same compatible strings).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/0243fe41/attachment.sig>

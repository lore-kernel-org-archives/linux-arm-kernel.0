From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 31 Jul 2015 12:42:51 +0200
Subject: [PATCH 0/9] gpiolib: Add GPIO name support
In-Reply-To: <20150731094928.GQ28535@localhost>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdY=SLGyrcvWT355b3Z+pBwb9gPzVcieD8mOn=zdyJ1mFw@mail.gmail.com>
 <CAAVeFuL5F=Y2boCWp_TZEAN-kdT-Ob9r-h1-eNVDjBHftFYkeg@mail.gmail.com>
 <20150721095457.GA9981@pengutronix.de>
 <20150721101037.GB20023@pengutronix.de>
 <CAGmoSHt0Kg-cxe3U6uV40=ttmFbDruRcJZNxtmSZ=gmZQN5fTw@mail.gmail.com>
 <20150731094928.GQ28535@localhost>
Message-ID: <20150731104251.GC1994@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 11:49:28AM +0200, Johan Hovold wrote:
> On Thu, Jul 30, 2015 at 05:13:37PM -0700, Arun Bharadwaj wrote:
> 
> > 2) Some times I get a kernel dump when I try to unexport the gpio or even
> > when I try to read the "name" file. This is not very repeatable and seems
> > to happen at random. I haven't had the time to look into this in more
> > detail yet, but here's the dump FWIW: http://pastebin.com/xq9cpCQE
> 
> This is probably because of patch 8/9 erroneously taking the sysfs_lock
> in gpio_name_show.

Arun, thank you for testing. I will send a fixed series at the beginning
of next week.

Best regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/409a0439/attachment.sig>

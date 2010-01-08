From: jvermillard@archean.fr (Julien Vermillard)
Date: Fri, 8 Jan 2010 18:29:42 +0100
Subject: S3C2440 : DM9000 link down when writing on NAND flash
In-Reply-To: <19270.64598.451295.134378@ipc1.ka-ro>
References: <20100108100805.15e4b558@jvermillard-portable>
	<19270.64598.451295.134378@ipc1.ka-ro>
Message-ID: <20100108182942.59ec0341@jvermillard-portable>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Fri, 8 Jan 2010 10:35:18 +0100,
Lothar Wa?mann <LW@KARO-electronics.de> a ?crit :

> Hi,
> 
> > I'm using a DM9000E with a S3C2440 CPU running 2.6.30.1. The DM9K is
> > connected on the CS4 (like the mini2440). I already had troubles
> > with the ethernet, and we applied (as suggested here) the DM900
> > errata consisting in gating IOR & CS. The DM9000 is working better
> > now, but when I write some file on the NAND Flash, the DM900 is
> > reseting (link down, link up). Reading from NAND flash is fine.
> > 
> I remember to have seen this before. You should search the archives of
> the old linux-arm-kernel mailinglist.
> 
> 
> Lothar Wa?mann

Already checked, except my old problem, I found nothing.
-- 
Julien Vermillard

Archean Technologies
http://www.archean.fr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 197 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100108/fb1370db/attachment.sig>

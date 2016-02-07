From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 07 Feb 2016 16:23:51 +0100
Subject: [PATCH v2 3/4] ARM: LG Optimus Black (P970) codename sniper
 support, with basic features
In-Reply-To: <1454701140.2623.12.camel@collins>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-4-git-send-email-contact@paulk.fr>
 <1454701140.2623.12.camel@collins>
Message-ID: <1454858631.2547.7.camel@aldrin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le vendredi 05 f?vrier 2016 ? 20:39 +0100, Paul Kocialkowski a ?crit :
> Le vendredi 05 f?vrier 2016 ? 19:42 +0100, Paul Kocialkowski a ?crit :
> > The LG Optimus Black (P970) codename sniper is a smartphone that was designed
> > and manufactured by LG Electronics (LGE) and released back in 2011.
> > It is using an OMAP3630 SoC, GP version.
> > 
> > This adds devicetree support for the device, with only a few basic features
> > supported, such as debug uart, i2c, internal emmc and external mmc.

[snip}

> > +&mmc2 {
> > +
> 
> Please discard this newline in case v2 gets merged.

All things considered, I'd rather not have this patch merged as-is, but
wait for the next version.

I'll wait for feedback before sending v3.

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160207/e83bf34d/attachment.sig>

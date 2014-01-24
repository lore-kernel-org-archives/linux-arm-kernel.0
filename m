From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 24 Jan 2014 12:35:30 +0200
Subject: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
In-Reply-To: <52E0333F.4000400@gmail.com>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
 <20140107235951.GH5074@atomide.com> <52CD5D13.9090806@ti.com>
 <79CD15C6BA57404B839C016229A409A83EDB11F5@DBDE04.ent.ti.com>
 <52CE5123.9050702@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EDB141E@DBDE04.ent.ti.com>
 <52D146E8.4090105@gmail.com> <52E0333F.4000400@gmail.com>
Message-ID: <52E241F2.2040103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-01-22 23:08, Ivaylo Dimitrov wrote:
> Hmm, maybe this https://lkml.org/lkml/2014/1/22/386 will solve our issues

I don't know, it wasn't immediately clear to me if the reserved memory
was handled with CMA or not.

Also, we have this funniness that omapfb is not present in DT data, so
we can't give reserved memory to omapfb directly like that.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140124/ee42870f/attachment.sig>

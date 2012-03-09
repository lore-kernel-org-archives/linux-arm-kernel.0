From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 09 Mar 2012 14:31:41 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 omap_dss2 tree
In-Reply-To: <201203091226.53749.arnd@arndb.de>
References: <20120308170048.f1a992bca2ca2d93fa9747bf@canb.auug.org.au>
 <201203091150.11294.arnd@arndb.de> <1331295269.1927.54.camel@deskari>
 <201203091226.53749.arnd@arndb.de>
Message-ID: <1331296301.1927.64.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-03-09 at 12:26 +0000, Arnd Bergmann wrote:
> On Friday 09 March 2012, Tomi Valkeinen wrote:

> > Merging omapdss tree through arm-soc would make sense for avoiding
> > conflicts, because almost every merge window there are some conflicts as
> > I often need to edit arch/arm files also. But I'm not sure if we have
> > ever had a conflict in drivers/video.
> > 
> > But still, it's a video driver, and fbdev tree sounds more suited for a
> > video driver.
> > 
> > So I don't know =). Basically it's ok for me either way also. But it
> > would be nice to have a standard way of doing this, instead of, for
> > example, merging omapdss sometimes through fbdev, sometimes through
> > arm-soc, depending on the conflicts...
> 
> Actually, I did not suggest omapdss through arm-soc, the idea was that
> that the same branch gets merged into both the fbdev and the arm-soc
> trees and let the fbdev tree go to Linus first.

Ah, right, now I see. This sounds ok to me. I'll cc you when I send the
pull request to Florian (presuming the arrangement is fine for him).

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/a5c2202a/attachment-0001.sig>

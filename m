From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jun 2014 16:22:25 +0200
Subject: [PATCH 00/17] ARM: S5P64X0, S5PC100: no more support in mainline
In-Reply-To: <6153646.CZ57BgYKf3@wuerfel>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <6153646.CZ57BgYKf3@wuerfel>
Message-ID: <20140630142224.GA30417@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 03:34:27PM +0200, Arnd Bergmann wrote:
> On Tuesday 01 July 2014 06:32:10 Kukjin Kim wrote:
> > This series removes S5P64X0 and S5PC100 related codes in mainline,
> > because no more user now. And if its supporting is required later,
> > it will be done with using device tree.
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

It seems like I'm not completely up-to-date. What happened to our prime
directive never to remove support for boards? Why is this special? What
about people that still use this hardware? The commit message says that
there are no longer any users. How was this determined?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/d8c55375/attachment.sig>

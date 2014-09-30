From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Sep 2014 10:59:46 +0100
Subject: [PATCH resend] arm:extend the reserved memory for initrd to be
 page aligned
In-Reply-To: <15815.1412018518@turing-police.cc.vt.edu>
References: <35FD53F367049845BC99AC72306C23D103D6DB49161F@CNBJMBX05.corpusers.net>
 <20140919095959.GA2295@e104818-lin.cambridge.arm.com>
 <20140925143142.GF5182@n2100.arm.linux.org.uk>
 <20140925154403.GL10390@e104818-lin.cambridge.arm.com>
 <35FD53F367049845BC99AC72306C23D103D6DB49163B@CNBJMBX05.corpusers.net>
 <15815.1412018518@turing-police.cc.vt.edu>
Message-ID: <20140930095946.GL5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 03:21:58PM -0400, Valdis.Kletnieks at vt.edu wrote:
> On Fri, 26 Sep 2014 10:40:54 +0800, "Wang, Yalin" said:
> 
> > I am really confused,
> > I read this web:
> > http://www.arm.linux.org.uk/developer/patches/info.php
> > it said use diff -urN to generate patch like this:
> >
> > diff -Nru linux.orig/lib/string.c linux/lib/string.c
> >
> > but I see other developers use git format-patch to generate patch and
> > submit to the patch system.
> > Git format-patch format can also be accepted by the patch system correctly ?
> > If yes, I think this web should update,
> > Use git format-patch to generate patch is more convenient than use diff -urN
> 
> 'diff -urN' has the advantage that it will work against a tree extracted
> from a release tarball, and doesn't have a requirement that you have git
> installed.  Having said that, somebody who has access to the website probably
> should update it to mention that both methods are acceptable....

As the website includes *examples* of git formatted patches, no change
is necessary.

I've learned through writing those instructions that it is a bad idea to
_add_ additional words, because it gives people _more_ things to argue
about.  One form of words or examples is fine for one group of people,
but completely confuses another group of people.  You can't win.

That is one of the biggest reasons I hate writing user documentation.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

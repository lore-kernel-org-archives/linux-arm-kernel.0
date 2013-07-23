From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Jul 2013 18:44:56 +0100
Subject: [PATCH 01/15] drivers: phy: add generic PHY framework
In-Reply-To: <20130723173710.GB28284@kroah.com>
References: <Pine.LNX.4.44L0.1307231017290.1304-100000@iolanthe.rowland.org>
 <51EE9EC0.6060905@ti.com> <20130723161846.GD2486@kroah.com>
 <1446965.6APW5ZgLBW@amdc1227> <20130723173710.GB28284@kroah.com>
Message-ID: <20130723174456.GM9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 10:37:11AM -0700, Greg KH wrote:
> On Tue, Jul 23, 2013 at 06:50:29PM +0200, Tomasz Figa wrote:

> > I fully agree that a simple, single string will not scale even in some, not 
> > so uncommon cases, but there is already a lot of existing lookup solutions 
> > over the kernel and so there is no point in introducing another one.

> I'm trying to get _rid_ of lookup "solutions" and just use a real
> pointer, as you should.  I'll go tackle those other ones after this one
> is taken care of, to show how the others should be handled as well.

What are the problems you are seeing with doing things with lookups?
Having to write platform data for everything gets old fast and the code
duplication is pretty tedious...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130723/5a9806af/attachment.sig>

From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 11:49:27 +0200
Subject: [PATCH] ARM: ux500: avoid warning in ux500_read_asicid
In-Reply-To: <CACRpkdZapi-xERDkjNz03VOJFFga090xvdqUrHUdY+05GS4MdA@mail.gmail.com>
References: <2475820.dXNmmAuTaP@wuerfel>
 <CACRpkdZapi-xERDkjNz03VOJFFga090xvdqUrHUdY+05GS4MdA@mail.gmail.com>
Message-ID: <2569975.7k6RRgccL8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 11:23:48 Linus Walleij wrote:
> On Fri, May 31, 2013 at 10:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > phys_addr_t may be 64 bit, which causes this harmless warning
> > in ux500_read_asicid:
> >
> 
> Patch applied to ux500-core for v3.11, as it doesn't seem to
> be a dangerous regression.
> 
> You'll get this back by pull request soon-ish.

Ok, thanks!

	Arnd

From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 20 Feb 2012 16:48:30 +0100
Subject: ftp.arm.linux.org.uk now using dumb http git protocol
In-Reply-To: <20120216131144.GM13673@n2100.arm.linux.org.uk>
References: <20120216131144.GM13673@n2100.arm.linux.org.uk>
Message-ID: <20120220154829.GA13322@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2012-02-16 13:11:44, Russell King - ARM Linux wrote:
> A couple of days I disabled the smart git protocol over http on
> ftp.arm.linux.org.uk because the smart git protocol over http is
> far too heavyweight for the poor x86 machine.  It's now using the
> lighter-weight dumb http file serving stuff instead.  This has made
> the machine load go back to virtually zero instead of skyrocketing.
> 
> It's revealed something rather interesting though: people _have_ been
> updating their trees from my tree without first ensuring that their tree
> is up to date with Linus' tree.  I suspect people have been cloning
> the tree as well.

Can you move your trees to kernel.org? That has enough horsepower to
handle git clone...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

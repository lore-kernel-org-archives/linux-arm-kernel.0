From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Jul 2012 08:41:40 +0000
Subject: [PATCH] ARM: PRIMA2: convert to common clk and finish full clk
 tree
In-Reply-To: <20120707023201.GC1230@gmail.com>
References: <1341568806-842-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4x=GuY4RPk+SaWisoar1Qb0Y8ox0TqXN2hbsNvOHi_J4Q@mail.gmail.com>
 <20120707023201.GC1230@gmail.com>
Message-ID: <201207070841.41494.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 July 2012, Mike Turquette wrote:
> I don't mind dropping your patches from clk-next and taking new ones.
> Go ahead and send me a new patch which does everything instead of an
> incremental patch to simply 'git mv' the code.  Feel free to split the
> patch up if needed.

FWIW, I would always recommend doing this in two patches, one that changes
the code and one that moves the file, in either order. The main difference
is that for those who cannot use 'git diff -M', reviewing the patch becomes
much easier when it doesn't look like one file is removed and another
completely different file is added.

	Arnd

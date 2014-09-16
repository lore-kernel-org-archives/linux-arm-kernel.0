From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Sep 2014 20:57:38 +0100
Subject: [PATCH 1/8] arm: Convert pr_warning to pr_warn
In-Reply-To: <1410884281.16519.2.camel@joe-AO725>
References: <cover.1410632834.git.joe@perches.com>
 <7995478e8c658478cd37dabb996f7269405251ac.1410632835.git.joe@perches.com>
 <20140915155656.GA29744@arm.com>
 <20140916160759.GJ12361@n2100.arm.linux.org.uk>
 <1410884281.16519.2.camel@joe-AO725>
Message-ID: <20140916195737.GO12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 09:18:01AM -0700, Joe Perches wrote:
> On Tue, 2014-09-16 at 17:07 +0100, Russell King - ARM Linux wrote:
> > any chance you could add a KernelVersion: tag somewhere in the
> > commit message and throw it at patches at arm.linux.org.uk so it doesn't
> > get lost?
> 
> There are no commit logs with a KernelVersion: tag
> in all of git history.

Right, that's not it's purpose.

> What do you think a KernelVersion: tag is and what
> would it be used for?

It's for that email address to know which kernel version the patch
was generated against, which is useful information when I come to
apply it.  It gets filtered out from the commit message.  It can go
anywhere, even below the -- line.

If you don't want to cooperate, you will have to rely on my notoriously
bad email skills to scan the mailing list for random patches to apply
some time (maybe days or even weeks) later after you send your message.
Which just won't happen.  It's why I wrote scripts which are some 20
years old to solve my bad email patch handling skills.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.

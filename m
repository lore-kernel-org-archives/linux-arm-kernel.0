From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 31 Aug 2012 13:25:19 +0100
Subject: [PATCH] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <5040A481.7020403@parrot.com>
References: <1346404916-27616-1-git-send-email-castet.matthieu@free.fr>
 <20120831110444.25d9b9fe@pyramind.ukuu.org.uk>
 <504091F0.1090703@parrot.com>
 <20120831103351.GE18957@n2100.arm.linux.org.uk>
 <20120831115939.23fd4a08@pyramind.ukuu.org.uk>
 <5040A481.7020403@parrot.com>
Message-ID: <20120831132519.7c33f648@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Then bury this crap in platform files please not in the drivers/tty layer
> > code. Make it a platform driver provided callback or something.
> > 
> I posted a new v2 patch that make the selection dynamic.

Thanks - fine with that one - or with burying it in headers etc in the arm
subdirs.

Greg's email address btw has changed - you want his current one as
suse.de bounces.

Alan

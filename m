From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2009 19:26:32 +0100
Subject: [RFC PATCH 05/10] PCMCIA: sa1111: wrap soc_pcmcia_socket to
	contain sa1111 specific data
In-Reply-To: <4ACCC66F.3060800@lwfinger.net>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
	<485cc33b078bb619d4544cf31388401dd1708029.1253722954.git.rmk+kernel@arm.linux.org.uk>
	<4AC92954.1010104@lwfinger.net>
	<20091004231402.GA31087@n2100.arm.linux.org.uk>
	<20091005112113.7d431aa6.kristoffer.ericson@gmail.com>
	<20091006104518.GA14717@n2100.arm.linux.org.uk>
	<4ACCC66F.3060800@lwfinger.net>
Message-ID: <20091007182632.GD11371@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2009 at 11:48:47AM -0500, Larry Finger wrote:
> Russell King - ARM Linux wrote:
> > This series has been rebased in my git tree - branch pcmcia.  I'll
> > avoid re-posting the patches since it appears to cause dwmw2's mail
> > server quite a bit of grief (it took well over an hour to deal with
> > the 10 patches last time I posted.)
> > 
> > Ignore the top commit of:
> > 
> > http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/pcmcia
> > 
> > As usual, it's also available in overall patch and mbox forms:
> > 
> > http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/
> 
> I "tested" the patches. The reason it is in quotes is that the change
> to Makefile, Kconfig and rsrc_nonstatic.c are the only parts that
> affected my system.

In what way?

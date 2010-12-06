From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Dec 2010 20:52:17 +0000
Subject: [PATCH 1/5] msm: Secure Channel Manager (SCM) support
In-Reply-To: <29863.1291665648@localhost>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
	<29863.1291665648@localhost>
Message-ID: <20101206205217.GJ31777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 06, 2010 at 03:00:48PM -0500, Valdis.Kletnieks at vt.edu wrote:
> On Sun, 05 Dec 2010 23:16:14 PST, Jeff Ohlstein said:
> 
> > SCM is the protocol used to communicate between the secure and
> > non-secure code executing on the applications processor. 
> 
> Does the presence of SCM hardware imply SMP?  From reading this, it's unclear
> why the dependence on SMP - it looks like scm.c is something that hardware that
> has one ARM processor and a 'secure processor' would still want.  Or is the
> 'secure processor' just another (arbitrarily labeled) ARM CPU participating
> as a full SMP processor?

It's referring to the secure mode, which is a separate address space and
system running on the same CPU.

From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 2 Jul 2012 10:05:38 -0400 (EDT)
Subject: [PATCH v3] ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset fix
 issues.
In-Reply-To: <CAP05o4JctmjdAk+S--v9T0PM0kabFN50ESyiPiwAYXNUX5yyBg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1207021003050.6472-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Jul 2012, Munegowda, Keshava wrote:

> Hi Samuel
>        please drop this patch for now , since Alan stern has mentioned
> improvements for this patch and we
> need to wait for Alan's new patch on ehci-omap.c and then Rus dill
> patch and my usbhs tll
> patch series need to be rebased.

No, that's okay.  I rebased my patch on top of Russ's; see

	http://marc.info/?l=linux-usb&m=134098478928668&w=2

so Russ's patch should be kept.  My patch needed other changes also, so
this wasn't a big deal.

The extra problems I mentioned in an earlier email will still need to
be fixed after both Russ's patch and my own are merged.

Alan Stern

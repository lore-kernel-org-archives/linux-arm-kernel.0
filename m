From: s-anna@ti.com (Anna, Suman)
Date: Wed, 13 Mar 2013 05:31:53 +0000
Subject: [PATCHv3 01/14] mailbox: rename pl320-ipc specific mailbox.h
In-Reply-To: <20130313035252.GA1515@kroah.com>
References: <1363145030-14373-1-git-send-email-s-anna@ti.com>
 <20130313035252.GA1515@kroah.com>
Message-ID: <37C860A02101E749A747FA2D3C1E3C504978B9@DLEE11.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Tue, Mar 12, 2013 at 10:23:50PM -0500, Suman Anna wrote:
> > The patch 30058677 "ARM / highbank: add support for pl320 IPC"
> > added a pl320 IPC specific header file as a generic mailbox.h.
> > This file has been renamed appropriately to allow the introduction of
> > the generic mailbox API framework.
> >
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/highbank-cpufreq.c |  2 +-
> >  drivers/mailbox/pl320-ipc.c        |  2 +-
> >  include/linux/mailbox.h            | 17 -----------------
> >  include/linux/pl320-ipc.h          | 17 +++++++++++++++++
> >  4 files changed, 19 insertions(+), 19 deletions(-)  delete mode
> > 100644 include/linux/mailbox.h  create mode 100644
> > include/linux/pl320-ipc.h
> 
> Why are you sending these To: me?  I'm not the mailbox maintainer, and have
> never handled them before that I can remember.  Who is the maintainer?

Er.. sorry Greg, I have taken the recipient list from the original series posting, but this series should have been directed to the ARM-SoC maintainer. The patches are generalizing the OMAP mailbox driver to add support for ST's mailbox as well,  and moving it to under /drivers/mailbox. The folder is new in 3.9, and the code under this, so far,  has all been for ARM based chips. I guess the maintainer for this folder needs to be sorted out for the long-term.

Regards
Suman

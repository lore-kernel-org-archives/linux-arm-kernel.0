From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Sep 2012 04:37:50 -0700
Subject: [PATCH v7 0/11] KGDB/KDB FIQ (NMI) debugger
In-Reply-To: <20120913150133.GA16238@lizard>
References: <20120913150133.GA16238@lizard>
Message-ID: <20120917113750.GA28838@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 08:01:33AM -0700, Anton Vorontsov wrote:
> Hi all,
> 
> Here comes the lucky v7:
> 
> - Per Alan Cox's suggestion added hangup method and removed a small
>   leftover;
> - Per Colin Cross' suggestion moved IRQ quiescing logic into
>   poll_get_char routine. IIUC, Alan is less unhappy about it.  As a
>   result, clear_irq() callback dropped.
> 
> These patches can be found in the following repo (based on tty-next):
> 
> 	git://git.infradead.org/users/cbou/linux-nmi-kdb.git master
> 
> Old changelogs and rationale for these patches can be found here:
> 
> 	v1-v5, rationale: http://lkml.org/lkml/2012/9/10/2
> 	v6: http://lkml.org/lkml/2012/9/10/2

I have no objection to these patches, and as they are based on my
tty-next tree, should I be the ones accepting them?  If so, then I need
a bunch of acks from others involved in the kdb/kgdb code before I can
do so.

To make it easier, can I just take the tty driver patches now?  Will
that break anything?

thanks,

greg k-h

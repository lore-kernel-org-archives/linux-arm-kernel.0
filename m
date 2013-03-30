From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 29 Mar 2013 21:36:25 -0400 (EDT)
Subject: [PATCH v3 4/7] USB: EHCI: export ehci_shutdown
In-Reply-To: <1364603383.16937.60.camel@smoke>
Message-ID: <Pine.LNX.4.44L0.1303292135300.26395-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Mar 2013, Geoff Levand wrote:

> Hi Alan,
> 
> > Actually, I think this is not necessary.  Instead those three glue
> > files ought to be changed.  They should not need to call
> > ehci_shutdown() directly.
> 
> I sent out a separate patch that removes the ehci_shutdown()
> call in ps3_ehci_remove().  I tested it by removing and
> installing the ehci_hcd module and it seems to work OK.

Thanks!  I'll send it on up.

Alan Stern

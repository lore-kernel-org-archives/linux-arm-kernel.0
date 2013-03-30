From: geoff@infradead.org (Geoff Levand)
Date: Fri, 29 Mar 2013 17:29:43 -0700
Subject: [PATCH v3 4/7] USB: EHCI: export ehci_shutdown
In-Reply-To: <Pine.LNX.4.44L0.1303291541460.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291541460.1467-100000@iolanthe.rowland.org>
Message-ID: <1364603383.16937.60.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

> Actually, I think this is not necessary.  Instead those three glue
> files ought to be changed.  They should not need to call
> ehci_shutdown() directly.

I sent out a separate patch that removes the ehci_shutdown()
call in ps3_ehci_remove().  I tested it by removing and
installing the ehci_hcd module and it seems to work OK.

-Geoff

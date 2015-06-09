From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 09 Jun 2015 14:24:43 +0200
Subject: [PATCH v4 2/2] dma: Add Xilinx AXI Central Direct Memory Access
 Engine driver support
In-Reply-To: <5576D83D.2000006@monstr.eu>
References: <1432228035-6569-1-git-send-email-appanad@xilinx.com>
 <1432290653.27695.97.camel@x220> <557681A7.7080202@monstr.eu>
 <alpine.DEB.2.02.1506090808500.2069@localhost6.localdomain6>
 <55769132.6070601@monstr.eu> <1433837720.16887.42.camel@x220>
 <5576C2F5.3050806@monstr.eu> <1433851175.16887.83.camel@x220>
 <5576D83D.2000006@monstr.eu>
Message-ID: <1433852683.24094.8.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-06-09 at 14:12 +0200, Michal Simek wrote
> ok. Will check all our drivers we have to get it synchronized but I
> expect that a lot of drivers have problems there.

So do I. Cleaning that all up would add a lot of churn. I'm _not_
volunteering to do that.

What I decided to do was to (try to) comment on each patch that adds
another license mismatch. The idea being that this might annoy someone
into suggesting a (mostly) fool proof alternative to MODULE_LICENSE().
That didn't really work out yet (though Julia's and your response is
encouraging)

On the sunny side I note that very few new mismatches get added (at
least, I tricked myself into believing that).

Thanks,


Paul Bolle

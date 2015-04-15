From: rick.jones2@hp.com (Rick Jones)
Date: Wed, 15 Apr 2015 10:55:16 -0700
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <1429120373.7346.125.camel@edumazet-glaptop2.roam.corp.google.com>
References: <alpine.DEB.2.02.1504091344260.7690@kaball.uk.xensource.com>
 <1428596218.25985.263.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
 <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
 <1428932970.3834.4.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAFLBxZYt7-v29ysm=f+5QMOw64_QhESjzj98udba+1cS-PfObA@mail.gmail.com>
 <1429115934.7346.107.camel@edumazet-glaptop2.roam.corp.google.com>
 <552E9E8D.1080000@eu.citrix.com>
 <1429118948.7346.114.camel@edumazet-glaptop2.roam.corp.google.com>
 <552EA2BC.5000707@eu.citrix.com>
 <1429120373.7346.125.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <552EA604.8010400@hp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Have you tested this patch on a NIC without GSO/TSO ?
>
> This would allow more than 500 packets for a single flow.
>
> Hello bufferbloat.

Woudln't the fq_codel qdisc on that interface address that problem?

rick

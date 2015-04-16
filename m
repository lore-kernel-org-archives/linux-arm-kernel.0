From: tim@xen.org (Tim Deegan)
Date: Thu, 16 Apr 2015 14:00:43 +0100
Subject: [Xen-devel] "tcp: refine TSO autosizing" causes performance
 regression on Xen
In-Reply-To: <552F9F60.7090406@eu.citrix.com>
References: <alpine.DEB.2.02.1504091729160.7690@kaball.uk.xensource.com>
 <CAFLBxZaVjFHh4UBnksGZS4waBr4jLdO8aJegyKvsU1-TvVt2Dg@mail.gmail.com>
 <1428932970.3834.4.camel@edumazet-glaptop2.roam.corp.google.com>
 <CAFLBxZYt7-v29ysm=f+5QMOw64_QhESjzj98udba+1cS-PfObA@mail.gmail.com>
 <1429115934.7346.107.camel@edumazet-glaptop2.roam.corp.google.com>
 <552E9E8D.1080000@eu.citrix.com>
 <1429119688.7346.123.camel@edumazet-glaptop2.roam.corp.google.com>
 <alpine.DEB.2.02.1504151846110.7690@kaball.uk.xensource.com>
 <1429121867.7346.136.camel@edumazet-glaptop2.roam.corp.google.com>
 <552F9F60.7090406@eu.citrix.com>
Message-ID: <20150416130043.GL13443@deinos.phlegethon.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At 12:39 +0100 on 16 Apr (1429187952), George Dunlap wrote:
> Your comment lists three benefits:
> 1. better RTT estimation
> 2. faster recovery
> 3. high rates
> 
> #3 is just marketing fluff; it's also contradicted by the statement that
> immediately follows it -- i.e., there are drivers for which the
> limitation does *not* give high rates.

AFAICT #3 is talking about throughput _under TCP_, where inflating the
RTT will absolutely cause problems.

Tim.

From: david-b@pacbell.net (David Brownell)
Date: Thu, 26 Aug 2010 11:30:03 -0700 (PDT)
Subject: gs_start_io() and gs_close()
In-Reply-To: <4C761243.6000606@compulab.co.il>
Message-ID: <215822.81660.qm@web180307.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >???seems wrong.


Does it cause an actual problem though?  Back when
that code was written and submitted, ISTR doing a
leak analysis and finding none on start_io() paths
or their cleanup siblings.  Did something change
since then?

I don't recall problems being reported in this area
over the past several years, either...

- Dave

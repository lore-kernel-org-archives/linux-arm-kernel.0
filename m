From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Thu, 25 Oct 2012 17:56:43 +0200
Subject: [RFC PATCH 00/13] sched: Integrating Per-entity-load-tracking
 with the core scheduler
In-Reply-To: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
References: <20121025102045.21022.92489.stgit@preeti.in.ibm.com>
Message-ID: <1351180603.12171.31.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, so I tried reading a few patches and I'm completely failing.. maybe
its late and my brain stopped working, but it simply doesn't make any
sense.

Most changelogs and comments aren't really helping either. At best they
mention what you're doing, not why and how. This means I get to
basically duplicate your entire thought pattern and I might as well do
the patches myself.

I also don't see the 'big' picture of what you're doing, you start out
by some weird avoid short running task movement.. why is that a good
start?

I would have expected a series like this to replace rq->cpu_load /
rq->load with a saner metric and go from there.. instead it looks like
its going about at things completely backwards. Fixing small details
instead of the big things.

Do explain..

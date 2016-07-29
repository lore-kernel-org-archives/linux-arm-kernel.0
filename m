From: jsun@junsun.net (Jun Sun)
Date: Fri, 29 Jul 2016 14:30:54 -0700
Subject: Can cores have different CPU features in a SMP system?
Message-ID: <CAP5Nno430Jt3Ax2jUPP6ELpVBF-pK0Akxsa8sZ55f8GL7LQt=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One specific example is that if a phone has two clusters.  Cores in
one cluster has v8 crypto extension and cores in the other don't.
Will this work?

My gut feeling is no, since many apps query cpu features at run-time.
And process can migrate among cores.  If an app starts on a core with
CE and migrates to another core without CE.  Illegal instruction fault
will happen.

Just wanna confirm if this is indeed the case.  Surprisingly google
search did not yield any meaningful answers.

Cheers.

Jun

From: josh.coombs@gmail.com (Josh Coombs)
Date: Sun, 17 Jun 2012 08:40:23 -0400
Subject: Converting kirkwood-goflexnet to DTS
In-Reply-To: <CAMW5UfZt_5ebcbRPfKn+aYkjzHcx5k7yV_PDmhdJaCMZos4Xsw@mail.gmail.com>
References: <20120614141706.GA6676@lunn.ch>
 <CAMW5UfaPLUt3mub-rpZGKYG5GzjMntvrCOwu-q3r-twm-AgD=g@mail.gmail.com>
 <CAMW5UfYwZkXzGbJTZ7tBr+eA5_+Jcri3FzsoaptXJV94j2okzw@mail.gmail.com>
 <20120615104140.24bf25f3@skate>
 <CAMW5UfaxqBXSToFGxiPu0GWFAeBddT-_XH8-Xv0A9L=XhDy7BQ@mail.gmail.com>
 <87r4tgvii8.fsf@lebrac.rtp-net.org>
 <CAMW5UfZt_5ebcbRPfKn+aYkjzHcx5k7yV_PDmhdJaCMZos4Xsw@mail.gmail.com>
Message-ID: <CAMW5Ufb1B6jETa47Z59uR_Rk0==kZ9c5OvjSz2KRbphSs8A6pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Decided to backtrack a bit.  I rolled my setup into 3.4.2 to see what
happens as I'm currently running that version via a non-DTS based
patch right now.  Same behavior, the kernel initializes but stops
before attaching a root device and firing up init.

I've got a couple more hacks to try next to see if I can pinpoint
what's keeping my GoFlex from working when other similar Kirkwoods
seem to play with DTS kernels just fine.

Josh Coombs

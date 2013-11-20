From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 20 Nov 2013 10:21:24 -0800
Subject: [BUG,REGRESSION?] 3.11.6+,3.12: GbE iface rate drops to few KB/s
In-Reply-To: <20131120181532.GM8581@1wt.eu>
References: <20131112083633.GB10318@1wt.eu> <87a9hagex1.fsf@natisbad.org>
 <20131112100126.GB23981@1wt.eu> <87vbzxd473.fsf@natisbad.org>
 <20131113072257.GB10591@1wt.eu> <20131117141940.GA18569@1wt.eu>
 <1384710098.8604.58.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131120171227.GG8581@1wt.eu> <20131120173436.GK8581@1wt.eu>
 <1384969222.10637.20.camel@edumazet-glaptop2.roam.corp.google.com>
 <20131120181532.GM8581@1wt.eu>
Message-ID: <1384971684.10637.22.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-11-20 at 19:15 +0100, Willy Tarreau wrote:

> No, I was on latest stable (3.10.19) which exhibits the regression but does
> not yet have your fix above. Then I tested the patch your proposed in this
> thread, then this latest one. Since the patch is not yet even in Linus'
> tree, I'm not sure Arnaud has tried it yet.

Oh right ;)

BTW Linus tree has the fix, I just checked this now.

(Linus got David changes 19 hours ago)

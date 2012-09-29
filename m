From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 29 Sep 2012 12:35:17 +0200
Subject: ARM SoC tree, Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem for MMIO
In-Reply-To: <1348868177-21205-6-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 28 Sep 2012 23:36:10 +0200")
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
Message-ID: <m3lift6rru.fsf_-_@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Krzysztof, please apply in your next branch so this problem goes away in
> 3.8.

Right, I'll look at it.

> I realize it won't make 3.7 any more since the base patches are not
> in arm-soc, but it's bad if linux-next is broken.

Well, I'm not aware of any requirement to push my IXP4xx changes
exclusively through arm-soc. I believe I can still send my tree straight
to Linus.

My tree is fairly isolated (with one trivial patch in need of ack from
Russell, but I can remove that) and, to be honest, I can't see any
benefit to anyone, caused by sending through intermediate trees. In
fact, now that I have at last a bit of spare time to work on IXP4xx
again (acquired some IXP435 devices), such requirement would only mean
extra workload to me.

Could you please point me to a statement requiring eg. my changes to go
through arm-soc?

Thanks.
-- 
Krzysztof Halasa

From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sat, 29 Sep 2012 19:02:36 +0200
Subject: ARM SoC tree,
 Was: Re: [PATCH 05/12] ARM: ixp4xx: use __iomem for MMIO
In-Reply-To: <201209291458.16112.arnd@arndb.de> (Arnd Bergmann's message of
 "Sat, 29 Sep 2012 14:58:15 +0000")
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-6-git-send-email-arnd@arndb.de>
 <m3lift6rru.fsf_-_@intrepid.localdomain>
 <201209291458.16112.arnd@arndb.de>
Message-ID: <m3y5jskbir.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

>> Could you please point me to a statement requiring eg. my changes to go
>> through arm-soc?
>
> We've been doing it like this for some time. Stephen Warren replied
> to your request to add your tree to linux-next in
>
> http://comments.gmane.org/gmane.linux.kernel/1356118
>
> explaining how it works. Olof sent a mail last week in 
>
> http://lkml.org/lkml/2012/9/21/31
>
> explaining that we're closing the window for 3.7 except for a
> few things that were already submitted earlier.

No offense, but... You say how does it work for YOU but that's not
exactly what I'm asking for. I'm asking for a statement that it's not OK
for me to push my IXP4xx changes straight to Linus.

> The arm-soc process is definitely meant to make your life easier
> as well as help Linus understand what's going on with all of ARM
> to the degree that he needs to know, but it only works if everyone
> participates.

I'd like to know how is it easier for me. Actually, I think it would
only make things worse for everyone (mostly for me). Also, I can't see
how "it only works if everyone participates" is true.

I'm currently supporting (for our internal needs) hw platforms based
on x86, MIPS and now ARM. I'm using 3.1 (non-trivial upgrades required
so -ETIME) and 3.5 "stable" trees, and need to also use Linus' current
tree since it's the next stable. The hw is e.g. Gateworks' platforms
with code taken from e.g. OpenWRT. I hope to have most of this in Linus'
tree when it's eventually ready. Unfortunately, I'm just one man, and
the above is only a slim part of my work. Egoistically, I don't think
I'm currently willing to spend time with arm-soc tree, if I can't see
any real technical benefit to anyone.

It would be different if my tree included e.g. core ARM changes - but it
doesn't. What's the _real_ reason for asking me to push my changes
indirectly?

Also, not that it's the most important, but how is it better for anyone
to delay changes - which are completely orthogonal to arm-soc - for
additional months? Doesn't "release early, release often" make sense
anymore?
-- 
Krzysztof Halasa

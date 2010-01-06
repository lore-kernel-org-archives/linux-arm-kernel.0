From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 6 Jan 2010 23:27:11 +0000
Subject: Sending UTF-8 patches (was: [PATCH 2/2] Remove now-defunct ts7250
	nand driver)
In-Reply-To: <1262819289.3181.8784.camel@macbook.infradead.org>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<20100106180705.GC11773@shareable.org>
	<alpine.LFD.2.00.1001061342240.21025@xanadu.home>
	<20100106230546.GD24250@shareable.org>
	<1262819289.3181.8784.camel@macbook.infradead.org>
Message-ID: <20100106232711.GF24250@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Woodhouse wrote:
> On Wed, 2010-01-06 at 23:05 +0000, Jamie Lokier wrote:
> > As I don't work with Git source and don't have enough time, I won't be
> > doing this, but I'd be delighted if someone else took the idea to the
> > Git people.  This thread could be used to explain why :-) 
> 
> I won't be bothering -- I'm quite happy just telling people not to send
> me legacy crap. There really is no justification for it, these days.

I suggest mutt users put this in .muttrc to work around git's inconsistency:

   set send_charset="us-ascii:utf-8"

If that's not acceptable, one could always add a hook to grep for a
patch when sending to decide what to do :-)

-- Jamie

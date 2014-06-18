From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 Jun 2014 12:09:29 -0400 (EDT)
Subject: Dove DT and HDMI on v3.16-rc1 (was: Re: [PATCH RFC 0/5] Dove PMU
 support)
In-Reply-To: <20140618150103.GE32514@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com> <20140615152554.GA13870@n2100.arm.linux.org.uk>
 <53A19DFA.7030207@gmail.com> <20140618143447.GA22890@arch.cereza>
 <20140618150103.GE32514@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1406181153130.16842@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jun 2014, Russell King - ARM Linux wrote:

> Even though the kernel side is supposed to be GPL, I'm really not happy
> distributing it or publishing changes as there are a number of files with
> headers which seem to be GPL-incompatible (which I've eliminated from my
> tree through updates) but the problem is wonderful git keeps them as
> history... and in my tree it's a massive 93 patches, against an old
> version of the code (0.8.0.1998) which I then sort-of updated to the
> version OLPC were carrying towards the start of 2013.

If you want to remove some files from git history, you may look at the 
git-filter-branch man page.  The first provided examples are most likely 
what you'd need.


Nicolas

From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Dec 2011 05:00:05 +0000
Subject: [linux-next] make  s5p64x0_defconfig build error
In-Reply-To: <20111214191205.GF14542@n2100.arm.linux.org.uk>
References: <1323838630.18517.1.camel@phoenix>
 <20111214123244.GE7122@mudshark.cambridge.arm.com>
 <20111214191205.GF14542@n2100.arm.linux.org.uk>
Message-ID: <20111215050005.GA24287@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 07:12:05PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 14, 2011 at 12:32:44PM +0000, Will Deacon wrote:

> >     ARM: restart: Temporary #error to persuade platform maintainers to take the restart changes seriously

> >     Force builds to fail to ensure that platform maintainers take the
> >     restart changes seriously, and sort out fixing their code before the
> >     next merge window.

> Indeed, and note the date, and how long its taken for just one of the
> platforms to be noticed.

I noticed s3c64xx the day you added that change but just deleted the
code so I could carry on working after my initial attempts to figure out
what this was about took too long.

> It seems to me that no one really cares about whether six of the seven
> platforms which have the #error build or don't build, so I really think
> there's a simple solution to this at the next merge window - delete any
> platform which hasn't _at_ _least_ responded with a proposed patch to
> this.

Do you have any references to this stuff?  I did make some effort to
understand what needed to be done but the patch doesn't mention which
restart changes are needed and my grovelling around in git wasn't
turning up enough context to tell me what was supposed to be happening
instead.  Frankly I've no need for that code in my systems so if it's a
problem I'd just throw the restart code away if it was that or breakage.

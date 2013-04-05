From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Apr 2013 22:33:25 +0200
Subject: [GIT PULL] Multi Cluster Power Management infrastructure
In-Reply-To: <20130405094159.GH17995@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.03.1303251219530.1372@syhkavp.arg>
 <alpine.LFD.2.03.1304042138160.1171@syhkavp.arg>
 <20130405094159.GH17995@n2100.arm.linux.org.uk>
Message-ID: <201304052233.25630.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Russell King - ARM Linux wrote:
> 
> Now, I'm currently on holiday.  I'm going to be on holday until after
> mid-April.  I'm not pulling anything until then.  I'm not applying anything
> until then.  I'm not even reading this mailbox - and given current mail
> rates at 300-400 messages per day, I will *not* be reading back over a
> fortnights worth of email.

I haven't reviewed the patches before, and only heard of the controversy
from Nico's email yesterday. Independent of your personal situation and
who implemented the code, I think it's clear that a lot of people (not
just Linaro) want to see it get merged and not having it upstream is
blocking platform specific code from getting put into arm-soc.

Since you are currently on holiday, I think it's best if we at least put
it into asm-soc as a for-rmk/mcpm branch in order to give it coverage
in linux-next and let us merge the dependent platform code into "late"
branches for 3.10. I still hope the nontechnical issues can be resolved
in time to let you pull it into your tree before the merge window.

Having just looked over the code myself for the first time, it
seems extremely much self-contained, so I see very little risk of
regressions and I'm sure any comments you have can be addressed in
follow-on patches.

	Arnd

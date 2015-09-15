From: peter@korsgaard.com (Peter Korsgaard)
Date: Tue, 15 Sep 2015 08:32:38 +0200
Subject: DSA: phy polling
In-Reply-To: <55F74D2A.8010104@gmail.com> (Florian Fainelli's message of "Mon,
 14 Sep 2015 15:41:46 -0700")
References: <20150914104254.GI21084@n2100.arm.linux.org.uk>
 <55F703D7.1070707@gmail.com>
 <20150914182314.GP21084@n2100.arm.linux.org.uk>
 <55F74D2A.8010104@gmail.com>
Message-ID: <87y4g8xke1.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Florian" == Florian Fainelli <f.fainelli@gmail.com> writes:

Hi,

 >> Does the Marvell phy have such a register?  Looking at the register
 >> dump and plugging/unplugging cables seems not to show a register
 >> reporting whether any particular interface has changed state, and
 >> I haven't noticed there being any combined register in anything I've
 >> seen on these switches.

 > It seemed to me like the PPU was meant to provide that, but I cannot
 > find any "summary" register which would give you such a status, must
 > have conflated that with what Broadcom switches support.

It's been some years, but I think the PPU was just to automatically
configure the switch MACs to to match the phy autonegotiation results.

I also don't see any summery register though.

-- 
Bye, Peter Korsgaard

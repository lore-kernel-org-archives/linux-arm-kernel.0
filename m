From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 14 Mar 2013 09:52:36 +0100
Subject: ARM: at-91: ARCH_AT91SAM9X5 went missing
In-Reply-To: <51418A98.3050009@atmel.com>
References: <1363171688.3137.196.camel@x61.thuisdomein>
 <51405F0D.40102@atmel.com> <1363173747.3137.202.camel@x61.thuisdomein>
 <20130313122605.GE2001@game.jcrosoft.org>
 <1363249052.1335.32.camel@x61.thuisdomein> <51418A98.3050009@atmel.com>
Message-ID: <1363251156.1335.35.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-03-14 at 09:30 +0100, Nicolas Ferre wrote:
> On 03/14/2013 09:17 AM, Paul Bolle :
> > And also note that ARCH_AT91SAM9X5 still is used as an (optional) dependency:
> >     $ git grep -n ARCH_AT91SAM9X5 v3.9-rc2
> >     v3.9-rc2:drivers/net/can/Kconfig:68:    depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
> 
> Which is removed by patch:
> "[PATCH v2 2/2] can: Kconfig: CAN_AT91 depends on ARM"
> 
> It should appear in CAN git tree soon.

Nice. Thanks for the clearing things up.


Paul Bolle

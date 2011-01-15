From: rabin@rab.in (Rabin Vincent)
Date: Sat, 15 Jan 2011 10:26:32 +0530
Subject: SMP: BUG() on cat /proc/$PID/stack
In-Reply-To: <20110113231136.GF24149@n2100.arm.linux.org.uk>
References: <AANLkTinSNPC7+m1Uie5hbUW_hgPecAK=RRGKkMx2AqOm@mail.gmail.com>
	<20110113231136.GF24149@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimaxWQBHA=N4X0sGr75L4z8D=RVRZMSLb49BNEh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 04:41, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> So, rather than going BUG(), lets instead return a terminated trace -
> something like this. ?Could you test and report back please?

Tested-by: Rabin Vincent <rabin@rab.in>

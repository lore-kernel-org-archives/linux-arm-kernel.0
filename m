From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 7 Mar 2012 14:30:30 +0000
Subject: DaVinci unbanked GPIO IRQs broken
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B6317A6E2B@DBDE01.ent.ti.com>
References: <70E876B0EA86DD4BAF101844BC814DFE0BF403DA89@Cloud.RL.local>
 <DF0F476B391FA8409C78302C7BA518B6317926BB@DBDE01.ent.ti.com>
 <DF0F476B391FA8409C78302C7BA518B6317A6E2B@DBDE01.ent.ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317EC8CA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Fri, Jan 27, 2012 at 18:49:42, Nori, Sekhar wrote:
> Hi Jon,
> 
> On Tue, Jan 17, 2012 at 15:32:23, Nori, Sekhar wrote:
> 
> > I was able to reproduce this on the EVM using v2.6.38 (works)
> > and v3.2 + my patch (doesn't work). I just started poking some
> > registers to see what is happening. Will keep you updated
> > on any progress.
> > 
> 
> Following patch fixes the issue of interrupt handler not getting
> called. I tested it using GPIO3 on DM365. On applying this, I
> see a constant rate of 4-5 interrupts per second on that line.
> Yet to figure out what is triggering those. Anyway I will wait for
> you to test this after you are back before sending this to Grant.

Are you back? Did you get a chance to test this?

Thanks,
Sekhar

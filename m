From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Feb 2015 09:17:09 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <20150224034548.GC18140@ld-irv-0074>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
 <87oaotaa6r.fsf@free.fr> <20150216205825.GG25269@lukather>
 <87k2zha69p.fsf@free.fr> <20150217103740.GK25269@lukather>
 <877fvga2mb.fsf@free.fr> <54E3777B.20607@free-electrons.com>
 <20150224034548.GC18140@ld-irv-0074>
Message-ID: <20150224081709.GM25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, Feb 23, 2015 at 07:45:48PM -0800, Brian Norris wrote:
> On Tue, Feb 17, 2015 at 02:16:43PM -0300, Ezequiel Garcia wrote:
> > On 02/17/2015 02:07 PM, Robert Jarzmik wrote:
> > > It will be Brian choice eventually, but if you say that you will submit that
> > > approach for next cycle, and yours for stable, and that for next you'll convert
> > > mdelay() to msleep(), I'll stop arguing.
> > 
> > How about you push a proper patchset with this alternative (and a nice
> > cover letter explaining the need for a threaded irq) so we can discuss
> > properly this new turn?
> 
> I think both Maxime's change (polling a new HW bit) and Robert J's
> change (move to a threaded IRQ) are good. I'll take another look, but I
> expect I'll take Maxime's v4 for the 4.0 cycle, and Robert J's v2 for
> 4.1 (or will we just jump straight to 5.0? I never know).

That's what I would expect too.

> Will I see a patch to convert to msleep() and/or a jiffies timeout
> in the near future?

As soon as both patches are merged.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150224/5b08ae21/attachment-0001.sig>

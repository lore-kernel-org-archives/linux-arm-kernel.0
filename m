From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 23 Jun 2013 20:00:57 -0300
Subject: [PATCH v7] ARM PJ4B: Add support for errata 4742
In-Reply-To: <20130623083055.GW2718@n2100.arm.linux.org.uk>
References: <1371828664-3681-1-git-send-email-gregory.clement@free-electrons.com>
 <1371828664-3681-2-git-send-email-gregory.clement@free-electrons.com>
 <20130622154421.GA475@localhost> <20130622155103.GA11542@1wt.eu>
 <20130623072058.GD11542@1wt.eu>
 <20130623083055.GW2718@n2100.arm.linux.org.uk>
Message-ID: <20130623230056.GA2324@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 09:30:55AM +0100, Russell King - ARM Linux wrote:
> On Sun, Jun 23, 2013 at 09:20:58AM +0200, Willy Tarreau wrote:
> > On Sat, Jun 22, 2013 at 05:51:03PM +0200, Willy Tarreau wrote:
> > > Interesting, I had the same issue and thought it was because of my
> > > tree, though visually I couldn't spot the issue. It probably was a
> > > space/tab issue only.
> > 
> > OK it was probably because of other pending changes since rc6, because
> > it applied perfectly on top of 3.10-rc7.
> 
> It needs its counterpart patch:
> 
> 049be07053ebbf0ee8543caea23ae7bdf0765bb2
> ARM: 7754/1: Fix the CPU ID and the mask associated to the PJ4B
> 

Yeap, that's the one I needed.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

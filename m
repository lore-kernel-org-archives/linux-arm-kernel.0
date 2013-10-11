From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Fri, 11 Oct 2013 11:05:32 +0200
Subject: [PATCH 3/8] ARM: l2x0: add Marvell Tauros3 compatible
In-Reply-To: <5255AE12.2000205@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1381235073-17134-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131008134100.GD1412@e106331-lin.cambridge.arm.com>
 <52542D64.5010800@gmail.com> <525433D3.2090906@free-electrons.com>
 <20131009085026.GD4981@e106331-lin.cambridge.arm.com>
 <5255AE12.2000205@gmail.com>
Message-ID: <20131011090532.GU633@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 09:27:14PM +0200, Sebastian Hesselbarth wrote:

> >>>>>This add a compatible for the Marvell Tauros3 cache controller which
> >>>>>is compatible with l2x0 cache controllers. While updating the binding
> >>>>>documentation, clean up the list of possible compatibles.
> >>>>>
> >>>>>Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >>>>>---
> 
> Added Jisheng and Lennert to Cc.
> 
> Lennert, while looking for differences between ARM PL310 and
> Marvell Tauros3 cache controller in a GPL'ed 2.6 kernel source
> from Asus, I found arch/arm/mm/cache-tauros3.c which states you
> as the original author. If that is wrong, please ignore this.

I'm the original author of cache-tauros2.c, but I've never heard of
Tauros3, and my name probably ended up in there via cp(1).

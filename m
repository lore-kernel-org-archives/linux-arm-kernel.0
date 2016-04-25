From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Mon, 25 Apr 2016 19:00:12 +0530
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <55296515.n2D97kIgVc@wuerfel>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <20160423065431.GA5840@afzalpc> <571DCD8D.8070605@arm.com>
 <55296515.n2D97kIgVc@wuerfel>
Message-ID: <20160425133012.GA4085@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 25, 2016 at 02:59:13PM +0200, Arnd Bergmann wrote:
> On Monday 25 April 2016 08:55:57 Vladimir Murzin wrote:

> What hardware platform do you use? It would be nice to make it a little
> more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
> the MMU disabled.

And for compiling user space, which toolchain is being used ? (i am
quite shaky on this question, since !MMU, assuming that the normal one
used for Cortex-A userspace can't be used)

Regards
afzal

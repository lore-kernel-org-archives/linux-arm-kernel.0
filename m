From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Sep 2013 18:12:06 +0200
Subject: [PATCH 0/5] Add Core Divider clock support for Armada 370/XP
In-Reply-To: <20130926160010.GD4583@localhost>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost>
 <5243E46B.2000406@free-electrons.com>
 <20130926152651.GC4583@localhost> <20130926174755.15a65f92@skate>
 <20130926160010.GD4583@localhost>
Message-ID: <20130926181206.70ef355b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu, 26 Sep 2013 13:00:11 -0300, Ezequiel Garcia wrote:

> Hm... could be. Considering the lack of hardware details (as you
> point out) maybe this is indeed the best option.
> 
> And it has the cool advantage of simplfying the clock tree, which
> is unnecessarily complex with the NAND ECC clock -> NAND clock layout.
> 
> On the other side, Emilio has just pointed out (in private) that
> there's a flag "CLK_SET_RATE_PARENT" that is meant for these cases.
> 
> Anyway, I feel inclined to your suggestion and just forget about the
> NAND ECC clock for good, which is only confusing.

Yes, I also believe it's the easiest solution.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

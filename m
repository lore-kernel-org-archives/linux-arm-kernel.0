From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 3 Nov 2009 14:51:41 +0100
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic v2
In-Reply-To: <63386a3d0910251518i42149642g183f2d3f6c43384f@mail.gmail.com>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
	<63386a3d0910251518i42149642g183f2d3f6c43384f@mail.gmail.com>
Message-ID: <63386a3d0911030551j1accd6fby7038895df544385b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/25 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2009/10/21 Linus Walleij <linus.walleij@stericsson.com>:
>
>> Changes v1->v2:
>> - Fixed Mikaels comments: spelling, terminology.
>> - Kept the functions inline: all uses and foreseen uses
>> ?are once per kernel and all are in __init or __cpuinit sections.
>> - Unable to break out common code - the code is not common and
>> ?implementing two execution paths will be more awkward.
>> - Hoping the tglx likes it anyway.
>
> Ping on tglx on this, I will uninline the functions if you think
> it's better in the long run, just tell me, else can you pick this
> patch?

Ping again...

Linus Walleij

From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 12 Jul 2010 16:18:01 -0700
Subject: ARM defconfig files
In-Reply-To: <201007121605.32462.davidb@codeaurora.org>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<201007121605.32462.davidb@codeaurora.org>
Message-ID: <AANLkTimho3rcoCZZ2PlC3B3KIZZhsEiTnTk-__n1q_Dy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/12 David Brown <davidb@codeaurora.org>:
>
> Do you have scripts or tools that you did this with, or is a manual
> process. ?We're about to add several new (ARM) targets, and it'd be
> nice to be able to make small defconfigs for those targets as well.

Uwe posted it earlier in this thread as an attachement, and I put the
python script into the merge commit message too. And we should
probably put it somewhere in scripts too, and/or make a 'make' target
to create the small config files.

I pushed it all out, and tagged it as -rc5.

                 Linus

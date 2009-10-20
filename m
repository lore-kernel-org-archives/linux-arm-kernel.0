From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 21 Oct 2009 00:16:56 +0200
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic
In-Reply-To: <4ADE3225.5050001@caviumnetworks.com>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
	<4ADE3225.5050001@caviumnetworks.com>
Message-ID: <63386a3d0910201516r71100657y92e3e6c2fab38db9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/10/20 David Daney <ddaney@caviumnetworks.com>:

>> Please do not make that functions inline. They are too large and there
>> is no benefit of inlining them.
>
> If that is the case, then perhaps they should not be defined in a header
> file.

Of course not. There are apropriate places to put them, but as stated
I think the use as it is today warrants having them inlined.

Linus Walleij

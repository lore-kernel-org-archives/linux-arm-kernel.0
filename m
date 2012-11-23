From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 22 Nov 2012 23:51:39 -0800
Subject: [PATCH 10/10] ARM: FIQ: Get rid of init_FIQ()
In-Reply-To: <1353656161.911816605@f287.mail.ru>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
 <1353652071.755665772@f76.mail.ru> <20121123065002.GB27827@lizard>
 <1353656161.911816605@f287.mail.ru>
Message-ID: <20121123075138.GA2136@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 11:36:01AM +0400, Alexander Shiyan wrote:
[...]
> got_no_fiq_insn also not initialized.

It is static, so by definition it is initialized to 0.

> I think as a whole on this issue requires additional comments from Russell
> as the author of implementation.
> 
> PS: In any case, I can reproduce it and check it out if you send me a patchset
> to my email as an attachment.

Sent privately.

Thanks,
Anton.

From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 29 Sep 2011 18:18:41 +0200
Subject: [PATCH 2/2 v2] plat-pxa: break out GPIO driver specifics
In-Reply-To: <CAN1soZyCLc-vA5heAWGKkajUx58a2BuiJskB6FApzGb+y0ZO0A@mail.gmail.com>
References: <1317121014-4749-1-git-send-email-linus.walleij@stericsson.com>
	<CAN1soZyCLc-vA5heAWGKkajUx58a2BuiJskB6FApzGb+y0ZO0A@mail.gmail.com>
Message-ID: <4E849A61.1040307@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/2011 05:26 PM, Haojian Zhuang wrote:
> I think that we can move gpio out of plat-pxa directory.

Patch [1/2] in this series does that?

> And gpio
> driver needs to be simplified by supporting both pxa and mmp.
>
> I sent a new patch series for review.
>    

Sure I'll have a look...

Yours,
Linus Walleij

From: avorontsov@mvista.com (Anton Vorontsov)
Date: Wed, 2 Jun 2010 17:07:10 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <4C0654A1.8060906@mvista.com>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
	<20100601165540.GC7123@oksana.dev.rtsoft.ru>
	<4C065349.80005@ru.mvista.com>
	<20100602125334.GA29292@oksana.dev.rtsoft.ru>
	<4C0654A1.8060906@mvista.com>
Message-ID: <20100602130710.GB11897@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 04:54:57PM +0400, Sergei Shtylyov wrote:
[...]
> >>>+	/* De-Asscer SATA Reset */
> >>>+	tmp = PM_SOFT_RST_REG;
> >>>+	tmp |= 0x1 << PM_SOFT_RST_REG_OFFST_SATA;
> >>   You have *REG_OFFSET* everywhere, and *REG_OFFST* here -- a typo?
> 
> >No, this is how PM_SOFT_RST_REG_OFFST_* bits actually named.
> 
>    Then I guess it's the typo(s) there. ;-)

Or maybe other "OFFSET"s were meant to be "OFFST", e.g. for less
typing, who knows? :-)

But sure, I agree, cns3xxx.h's bit descriptions could be better.
In my todo list now.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2

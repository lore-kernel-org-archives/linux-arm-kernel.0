From: avorontsov@mvista.com (Anton Vorontsov)
Date: Wed, 2 Jun 2010 16:53:34 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <4C065349.80005@ru.mvista.com>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
	<20100601165540.GC7123@oksana.dev.rtsoft.ru>
	<4C065349.80005@ru.mvista.com>
Message-ID: <20100602125334.GA29292@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 04:49:13PM +0400, Sergei Shtylyov wrote:
[..]
> >+	/* De-Asscer SATA Reset */
> >+	tmp = PM_SOFT_RST_REG;
> >+	tmp |= 0x1 << PM_SOFT_RST_REG_OFFST_SATA;
> 
>    You have *REG_OFFSET* everywhere, and *REG_OFFST* here -- a typo?

No, this is how PM_SOFT_RST_REG_OFFST_* bits actually named.

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2

From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 02 Jun 2010 16:54:57 +0400
Subject: [PATCH 3/4] ARM: cns3xxx: Add support for AHCI controllers
In-Reply-To: <20100602125334.GA29292@oksana.dev.rtsoft.ru>
References: <20100601165409.GA29614@oksana.dev.rtsoft.ru>
	<20100601165540.GC7123@oksana.dev.rtsoft.ru>
	<4C065349.80005@ru.mvista.com>
	<20100602125334.GA29292@oksana.dev.rtsoft.ru>
Message-ID: <4C0654A1.8060906@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Anton Vorontsov wrote:

>>> +	/* De-Asscer SATA Reset */
>>> +	tmp = PM_SOFT_RST_REG;
>>> +	tmp |= 0x1 << PM_SOFT_RST_REG_OFFST_SATA;
>>    You have *REG_OFFSET* everywhere, and *REG_OFFST* here -- a typo?

> No, this is how PM_SOFT_RST_REG_OFFST_* bits actually named.

    Then I guess it's the typo(s) there. ;-)

WBR, Sergei

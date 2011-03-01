From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 01 Mar 2011 20:57:12 +0300
Subject: [PATCH] ARM: vexpress ct-ca9x4: only set twd_base if local timers
	are	being used
In-Reply-To: <000801cbd836$828d8f20$87a8ad60$@deacon@arm.com>
References: <1288891845-12630-1-git-send-email-will.deacon@arm.com>	<4D6D2B98.4090501@ru.mvista.com>
	<000801cbd836$828d8f20$87a8ad60$@deacon@arm.com>
Message-ID: <4D6D3378.8020306@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Will Deacon wrote:

>>> In commit bde28b84, I made the assumption that CONFIG_SMP is always set
>>     Linus asks to also specify the commit summary in parens.

> Well he merged it for v2.6.37 so I guess it's not the end of the world.

    Heh, didn't realize I was replying to such an old email. :-)

> Will

WBR, Sergei

From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 24 Jun 2014 09:55:27 +0200
Subject: [PATCH] ARM: mvebu: Fix the improper use of the compatible string
 armada38x using a wildcard
In-Reply-To: <20140623215309.GD10202@titan.lakedaemon.net>
References: <1403533011-21339-1-git-send-email-gregory.clement@free-electrons.com>
 <20140623215309.GD10202@titan.lakedaemon.net>
Message-ID: <53A92EEF.6070803@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

>> This fix should be merged in 3.16 and maybe sent as a fix for 3.15
>> too.

[...]

> Applied to mvebu/dt with Andrew's Ack.

I think it should go mvebu/fixes as this patch modifies the binding,
sooner is better.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

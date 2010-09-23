From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 23 Sep 2010 11:22:36 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <4C9B0D4D.4050102@atmel.com> (Nicolas Ferre's message of "Thu, 23
	Sep 2010 10:18:21 +0200")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com>
Message-ID: <87k4mcak6b.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Nicolas" == Nicolas Ferre <nicolas.ferre@atmel.com> writes:

Hi,

 Nicolas> By the way, I suspect that at91sam9g20 has the same issue
 Nicolas> (400MHz core also)...

 Nicolas> We may also have a look at at91sam9g10 which embeds a 266MHz
 Nicolas> core....

Yes, but I don't have access that hw, so it's hard to know exact udelay
values. udelay=5 for 9g20 and udelay=3 for 9g10 probably aren't far off,
but it would be nice if someone with hw could test.

-- 
Bye, Peter Korsgaard

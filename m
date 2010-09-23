From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 23 Sep 2010 12:24:42 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100923100928.GX32018@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Thu, 23 Sep 2010 12:09:28 +0200")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
	<20100923093104.GA22397@n2100.arm.linux.org.uk>
	<20100923100928.GX32018@game.jcrosoft.org>
Message-ID: <87bp7oahat.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jean-Christophe" == Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> writes:

Hi,

 Jean-Christophe> and we can not fix it easly so I do think it will be
 Jean-Christophe> better to pass the speed of the bus that we want from
 Jean-Christophe> the board and then calcualte it depending on the SOC

Configurable i2c bus speed for boards wanting something else than the
standard 100KHz could certainly be a nice thing, but that's something
that can be added later when/if needed.

-- 
Bye, Peter Korsgaard

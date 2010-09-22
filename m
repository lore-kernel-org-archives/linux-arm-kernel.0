From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Wed, 22 Sep 2010 17:18:57 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100922143406.GT32018@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Wed, 22 Sep 2010 16:34:06 +0200")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<20100922104846.GQ32018@game.jcrosoft.org>
	<87lj6uavde.fsf@macbook.be.48ers.dk>
	<20100922143406.GT32018@game.jcrosoft.org>
Message-ID: <87hbhhbyce.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Jean-Christophe" == Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> writes:

Hi,

 >> You don't expect most 9g45 users will run at 400MHz? It seems pretty
 >> likely to me. In any case, a safe (but somewhat slow) default seems
 >> better than a potentially unsafe one.
 >> 
 >> Now, I agree that it would be nice to add an interface to tweak this
 >> delay if needed (extra argument to at91_add_device_i2c()?), but that's
 >> next to the discussion about what the default should be.

 Jean-Christophe> I'd prefer to calculate it

 Jean-Christophe> so we specify which max freq we want in my mind it
 Jean-Christophe> will be good to be as in spi to specific per device
 Jean-Christophe> it's max speed so we can adapt the bus freq

Yes, that sounds like a nice long term idea, but let's fix the immediate
problem in the mean time, right?

-- 
Bye, Peter Korsgaard

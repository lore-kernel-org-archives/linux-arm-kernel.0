From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Sat, 18 Sep 2010 15:06:31 +0200
Subject: [PATCH] at91: fix arch_gettimeoffset fallout
In-Reply-To: <1284745298.2451.6.camel@localhost.localdomain> (john stultz's
	message of "Fri, 17 Sep 2010 10:41:38 -0700")
References: <1284730276-21657-1-git-send-email-jacmet@sunsite.dk>
	<1284745298.2451.6.camel@localhost.localdomain>
Message-ID: <87bp7v5hgo.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "john" == john stultz <johnstul@us.ibm.com> writes:

 john> On Fri, 2010-09-17 at 15:31 +0200, Peter Korsgaard wrote:
 >> 5cfc8ee0bb51 (ARM: convert arm to arch_gettimeoffset()) marked all of
 >> at91 AND at91x40 as needing ARCH_USES_GETTIMEOFFSET, and hence no high
 >> res timer support / accurate clock_gettime() - But only at91x40 needs it.

 john> Huh, sorry I missed that subtlety! Thanks for hunting this down!

No problem - Thanks for cleaning up the timer handling in the first
place.

-- 
Bye, Peter Korsgaard

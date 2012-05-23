From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 23 May 2012 21:07:46 +0200
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <201205231743.50262.arnd@arndb.de> (Arnd Bergmann's message of
 "Wed, 23 May 2012 17:43:49 +0000")
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231743.50262.arnd@arndb.de>
Message-ID: <87396qbtrx.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 23 May 2012, Richard Cochran wrote:
>> Once again, ixp4xx no longer even compiles. This patch fixes the issue
>> by converting over to gpiolib. This patch was first made by Imre and
>> posted by Marc, and I added in Russell's suggestion to empty the gpio
>> header file.
>> 
>> This fix should also go for 3.1, 3.2, 3.3, and 3.4.
>> 
>> Signed-off-by: Richard Cochran <richardcochran@gmail.com>
>> Cc: <stable@vger.kernel.org>
>
> So has every kernel since 3.1 been broken, or is it just broken now
> but a good idea to backport anyway?

every kernel since 3.1 (even 3.1-rc-something). Would be nice to see
this issue fixed as similar patches have been sent from time to time but
never been merged.

Arnaud

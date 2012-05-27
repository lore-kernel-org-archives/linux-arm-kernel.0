From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 27 May 2012 22:52:48 +0200
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <87396qbtrx.fsf@lebrac.rtp-net.org> (Arnaud Patard's message of
 "Wed, 23 May 2012 21:07:46 +0200")
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <201205231743.50262.arnd@arndb.de> <87396qbtrx.fsf@lebrac.rtp-net.org>
Message-ID: <m3bol9ibxb.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org> writes:

>> So has every kernel since 3.1 been broken, or is it just broken now
>> but a good idea to backport anyway?
>
> every kernel since 3.1 (even 3.1-rc-something). Would be nice to see
> this issue fixed as similar patches have been sent from time to time but
> never been merged.

Is it really that bad? I'm using IXP425 with 3.2 and it definitely
compiles (and works). Extra patches maybe? I can't see anything obvious.

I can only promise I'll scan the mail backlog (which is huge) and fix
the mess.
-- 
Krzysztof Halasa

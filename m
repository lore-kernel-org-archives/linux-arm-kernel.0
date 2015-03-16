From: peter@korsgaard.com (Peter Korsgaard)
Date: Mon, 16 Mar 2015 20:51:34 +0100
Subject: [PATCH 05/35 linux-next] tty: constify of_device_id array
In-Reply-To: <1426533469-25458-6-git-send-email-fabf@skynet.be> (Fabian
 Frederick's message of "Mon, 16 Mar 2015 20:17:11 +0100")
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-6-git-send-email-fabf@skynet.be>
Message-ID: <878uewen5l.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Fabian" == Fabian Frederick <fabf@skynet.be> writes:

 > of_device_id is always used as const.
 > (See driver.of_match_table and open firmware functions)

 > Signed-off-by: Fabian Frederick <fabf@skynet.be>
 > ---

For this:

>  drivers/tty/serial/uartlite.c               | 2 +-

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard

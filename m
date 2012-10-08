From: tbm@cyrius.com (Martin Michlmayr)
Date: Mon, 8 Oct 2012 19:40:16 +0100
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <201209251228.25752.arnd@arndb.de>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <201209251120.54255.arnd@arndb.de>
 <87haqmgw6n.fsf@lebrac.rtp-net.org>
 <201209251228.25752.arnd@arndb.de>
Message-ID: <20121008184016.GA30416@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [2012-09-25 12:28]:
> The hard part is finding those users. Once we know who they are, we can
> either try to help out by writing a dts file and letting them test it,
> or by assisting them in the process to write one themselves.
...
> We should certainly make sure we don't remove those machines as long
> as Debian supports them.

Arnaud Patard pointed out this conversation to me.  I added Orion and
Kirkwood support to Debian.  Unfortunately, I don't have a lot of
time these days but there are definitely still Debian users on Orion
and I would like to continue supporting them.

If someone volunteers to keep the Orion code up-to-date and/or port it
to DT, I can perform tests from time to time.  I have the following
Orion devices: QNAP TS-209, QNAP TS-409, HP mv2120 and D-Link DNS-323.

If someone wants to work on Orion kernel support, I can also make a
QNAP TS-409 main board and a D-Link DNS-323 device available.

(Please CC me since I'm currently not subscribed.)
-- 
Martin Michlmayr
http://www.cyrius.com/

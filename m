From: tbm@cyrius.com (Martin Michlmayr)
Date: Sat, 6 Feb 2016 15:19:35 -0800
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <20160206183414.GD17218@lunn.ch>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
 <20160206183414.GD17218@lunn.ch>
Message-ID: <20160206231935.GA30734@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew Lunn <andrew@lunn.ch> [2016-02-06 19:34]:
> Can you find an easily way to reproduce it? iperf, or scp a big file
> etc.

FWIW, we had a similar bug report in Debian recently:
https://lists.debian.org/debian-arm/2016/01/msg00098.html

Turning off TCP RX and TX offloading make it go away:
https://lists.debian.org/debian-arm/2016/01/msg00100.html

Hopefully Thomas can do a bisect.

-- 
Martin Michlmayr
http://www.cyrius.com/

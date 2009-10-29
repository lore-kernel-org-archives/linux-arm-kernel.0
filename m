From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Thu, 29 Oct 2009 10:10:10 +0100
Subject: ep93xx Ethernet hangs!
In-Reply-To: <8e7afda70910290125x2c4a7308k53f07a8cfba62792@mail.gmail.com>
References: <8e7afda70910280402r41e198cet6fc92817cd1c847f@mail.gmail.com>
	<8e7afda70910290125x2c4a7308k53f07a8cfba62792@mail.gmail.com>
Message-ID: <20091029091010.GR4179@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Oct 29, 2009 at 09:25:07AM +0100 Markus Kreidl ha dit:

> Correction test result: The ep93xx board is still pingable.

thanks for the update

in this case, i'm not sure if we observe the same behaviour. i'm
almost sure i tried to ping the device and got no response. what
definitely doesn't work in my case is connecting to the device via
telnet or accessing an http server from within the device.

best regards

-- 
Matthias Kaehlcke
Embedded Linux Engineer
Barcelona

                If you don't know where you are going,
               you will probably end up somewhere else
                         (Laurence J. Peter)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-

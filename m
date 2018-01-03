From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 3 Jan 2018 14:56:35 +0100
Subject: Vibrations, audio, charging, radio on N9/N950
Message-ID: <20180103135635.GA17854@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Sebasian, you submitted patch to enable vibrations on N950. I am
trying to do the same now on N9... I guess I enabled the dts, but
.. how do I actually ask for vibrations? /dev/input/eventX does not
seem to be present.

Did anyone get audio to run on N9/N950? It is marked as supported on
https://elinux.org/N950 with dt glue missing...

Even more importantly, does battery charging work for someone? It does
not work here :-(. After USB is plugged in, it maybe tries to charge,
but gives up after 30 seconds.

Maybe least important, but... does anyone have FM radio working? I'd
like to play some music...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180103/d6154afd/attachment.sig>

From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 25 Sep 2013 09:24:39 +0200
Subject: [PATCH] IXP4xx: Add Gateworks Cambria support.
In-Reply-To: <op.w3pc81032s3iss@ecaz> (Imre Kaloz's message of "Fri, 20 Sep
 2013 11:13:39 +0200")
References: <m3vc1ya9fw.fsf@t19.piap.pl> <op.w3oex8sc2s3iss@ecaz>
 <m37gebanth.fsf@t19.piap.pl> <op.w3pc81032s3iss@ecaz>
Message-ID: <m31u4dbbyg.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Imre Kaloz" <kaloz@openwrt.org> writes:

> So you delete portions of the code because you don't want to ask
> someone with the board to test your changes if needed, but given quite
> some people use the code for quite some time, you can also assume it
> works for them.

No, I didn't delete any code at all. Look at the patch again, it's only
adding stuff.
I have picked up parts of your code (parts of another project). GPL
doesn't allow a requirement that I have to take the whole.

> OpenWrt (yeah, we spell it this way for about 10 years now)

Sorry, didn't know, I don't use it.

> is a Linux distribution, you do mix things up a bit here.

Well, at least Cambria code is not a part of the official Linux then.

> It's up to you if you add your copyright, but removing others' is
> clearly a different story legally. And I bet that's the same in your
> country, too.

You are making things up. I didn't remove anything. I've created
a derivative work of (among others) your project. The copyright for the
base work doesn't apply for the derivative work, the creator of the
derivative work formally holds the copyright. The GPL explicitly allows
creating derivative works - actually, the whole point about GPL is
encouraging derivative works. OpenWrt is based on other works in
precisely the same way.

I didn't include my copyright because I didn't care a bit. The code in
question is mostly a trivial list of devices, and I guess in most parts
it's not even copyrightable. Remember, copyright is about the form, and
there aren't two ways to express e.g. that it has a serial port
(identical to other IXP4xx platforms), that it has a NOR flash
(identical to others) and so on.

> I'll do when I'll get around it. Both others and we've pushed a lot of
> code upstream. In the meantime, anyone is free to do so, including you
> - dumbing down the code could be justifiable in some cases (I don't
> think this one applies), but dropping others' copyright -- hardly.

Again, creating derivative works by picking up needed parts is not
dropping or dumbing anything. You are trying to force your view of what
is justifiable and what does apply. There is absolutely no legal or
other basis for this.

I have to say I'm disappointed. I didn't expect such reaction from you.
Actually I thought I was helping your project a bit (and my project, of
course). Since the former is not the case, I'm simply withdrawing my
patch.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

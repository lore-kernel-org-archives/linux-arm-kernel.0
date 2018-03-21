From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 21 Mar 2018 20:32:26 +0100
Subject: 4.16-rc5 on Motorola Droid 4
In-Reply-To: <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
References: <20180318220418.GA22880@amd> <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
Message-ID: <20180321193225.GA20561@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Maybe get somebody to help you locally with the debug cable
> > soldering? :)
> 
> I suppose people from your hackerspace can help you. It's really
> easy to do. Soldering can be avoided btw. You can just use a pair
> of scissors to cut a USB -> Micro USB cable and use a knife to remove
> isolation. Then screw each of the 4 wires into a terminal strip.
> There are USB-TTL adapters available, that have an attached cable.
> If you also cut the connector from such a cable and connect it to
> the other side of the terminal strip you are done. No soldering
> involved ;)

Hehe. After some more experiments, it looks like hardware hacking can
not be avoided :-(.

I should have enough connectors, but I don't know the pinouts. I also
seem to have D-SUN USB to TTL from you (thanks again!).

You say TTL, Tony says 3V3... so I guess the port can survive both?

Ok, I guess I really only need to connect GND, and then D- to RXD?

So... where is the D-.. aha, got it. I hope USB has to be robust
enough against me making experiments?

I connected it the best way I could, but I do not get data in minicom,
and RXD led stays lit. I guess that is not a good thing :-(.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180321/7dfb02ce/attachment.sig>

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Oct 2012 20:10:13 +0000
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <20121008195706.GM21046@lunn.ch>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20121008184016.GA30416@jirafa.cyrius.com> <20121008195706.GM21046@lunn.ch>
Message-ID: <201210082010.13928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 October 2012, Andrew Lunn wrote:
> > Arnaud Patard pointed out this conversation to me.  I added Orion and
> > Kirkwood support to Debian. 
> 
> I used your guide at http://www.cyrius.com/debian/kirkwood/qnap/
> to convert my QNAP-119P+ over to Debian. Works great.
> 
> > If someone volunteers to keep the Orion code up-to-date and/or port it
> > to DT, I can perform tests from time to time.  I have the following
> > Orion devices: QNAP TS-209, QNAP TS-409, HP mv2120 and D-Link DNS-323.
> 
> At the moment Kirkwood is my priority, but i think we should have most
> of it converted to DT in the next three months. Once that is over, i
> can look at Orion5x.
> 
> It is great you offered to test. I have a Marvell orion5x reference
> system, rd88f5182. So i can do a lot of the conversion using
> that. What i think will cause problems is PCI. There is scary looking
> PCI code in the -setup.c files. I don't know how easy that will be to
> convert to DT. However, it looks like most targets don't actually use
> PCI, so maybe some will be easier to convert than others.

I can offer some help with the PCI bits. I don't have any orion hardware,
but if you get stuck, you can find me on IRC or we can talk on the phone
about how it should be done.

	Arnd

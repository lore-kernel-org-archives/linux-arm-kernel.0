From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 May 2013 08:46:16 +0100
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on
 Armada 370/XP
In-Reply-To: <201305240915.27847.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305232240.03959.arnd@arndb.de>
 <20130523230911.GR18614@n2100.arm.linux.org.uk>
 <201305240915.27847.arnd@arndb.de>
Message-ID: <20130524074616.GV18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 24, 2013 at 09:15:27AM +0200, Arnd Bergmann wrote:
> On Friday 24 May 2013, Russell King - ARM Linux wrote:
> > No, I'm not asking about the principle.  I'm asking _in this particular
> > problem case_ who provides the DT blob?
> > 
> > So the person to answer that question is Thomas or someone who is using
> > the boards concerned.
> 
> But there is no problem on those boards /yet/.

Wrong, again.  Thomas has already said there are boot loaders shipping
on boards which have the registers programmed to be at 0xf1xxxxxx _and_
there's boards with boot loaders programmed for 0xd0xxxxxx.

The problem is here TODAY.

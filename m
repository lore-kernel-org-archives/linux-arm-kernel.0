From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jan 2014 13:45:40 +0100
Subject: iop32x: gpio breakage after "instantiate GPIO from platform
 device"
In-Reply-To: <CACRpkdbd1FOOZOrF5crh3dYfYOy1CaYFH-SOqw_SJmd39JBjhg@mail.gmail.com>
References: <4202760.m9CxkiIWk3@wuerfel>
 <CACRpkdbd1FOOZOrF5crh3dYfYOy1CaYFH-SOqw_SJmd39JBjhg@mail.gmail.com>
Message-ID: <4529033.RhLP7Lt6Fg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 January 2014 13:41:59 Linus Walleij wrote:
> On Tue, Jan 28, 2014 at 10:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Commit 7b85b867b9904 "ARM: plat-iop: instantiate GPIO from platform
> > device" nicely cleaned up the gpio register access for iop, but
> > forgot one board that directly pokes into the gpio registers
> > to do a system reset.
> >
> > That board no longer compiles, and this patch just disables
> > the code in question to work around it so I can locally build
> > randconfig again, but it needs to be fixed properly.
> 
> OK I'm sending a proper fix instead.

Ok, thanks!

	Arnd

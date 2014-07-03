From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Jul 2014 21:40:58 +0200
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703190742.GE32514@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <15521199.3bNj4354Mf@wuerfel> <20140703190742.GE32514@n2100.arm.linux.org.uk>
Message-ID: <5086720.ZpuobPQnBC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 July 2014 20:07:42 Russell King - ARM Linux wrote:
> On Thu, Jul 03, 2014 at 08:53:06PM +0200, Arnd Bergmann wrote:
> > It's certainly a very lengthy process. Just look at how long NWFPE has
> > been in the kernel after it has become obsolete.
> 
> May I remind you that I still run OABI... and still use NWFPE here.
> The machine which runs this mutt uses NWFPE with OABI.  The machine
> that exim passes the message on to runs NWFPE with OABI.  The machine
> which runs screen and irssi runs NWFPE with OABI.  The machine here
> which operates as a print server runs NWFPE with OABI.  That's four
> machines.

But the real question is whether you'd want to upgrade your user
space if you get to replace some of these four machines with 64-bit
hardware.

	Arnd

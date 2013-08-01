From: davej@redhat.com (Dave Jones)
Date: Wed, 31 Jul 2013 22:59:11 -0400
Subject: [Ksummit-2013-discuss] [ARM ATTEND] catching up on exploit
 mitigations
In-Reply-To: <CAOesGMiBa7fT+HZquNrwV=3P=Z-F9c8L7YQr7=D2BO_6pJXQ0w@mail.gmail.com>
References: <CAGXu5jKv9Vt+Hu0mFYaxggLLDZ46U3KR9MKegUoHH8StXCkBtQ@mail.gmail.com>
 <20130730221435.GA22240@redhat.com>
 <20130730231120.GC30725@blackmetal.musicnaut.iki.fi>
 <20130730231533.GA26824@redhat.com>
 <20130730235834.GD30725@blackmetal.musicnaut.iki.fi>
 <20130731000444.GC1281@redhat.com>
 <20130731094012.GU24642@n2100.arm.linux.org.uk>
 <20130731142430.GA4545@redhat.com>
 <CAOesGMiBa7fT+HZquNrwV=3P=Z-F9c8L7YQr7=D2BO_6pJXQ0w@mail.gmail.com>
Message-ID: <20130801025911.GA20166@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 07:47:30PM -0700, Olof Johansson wrote:

 > >  > Hmm, really?  Did you reported these bugs?  I'm not aware of mainline
 > >  > having any changes related to bug reports on PTEs on ARM.
 > >
 > > I wasn't sure if it was a googleism, or happens on mainline, so no.
 > 
 > As of 3.10, it's not actually hard to run a mainline kernel on the
 > chromebook, but you have limited functionality (no wifi, no USB3, no
 > accellerated graphics). Easiest is to do it by booting from SD card.
 > See instructions at
 > http://www.chromium.org/chromium-os/u-boot-porting-guide/using-nv-u-boot-on-the-samsung-arm-chromebook.
 
Yeah, that's how I got Fedora running on it (I think the people who did the
Fedora spin for the chromebook chose the google kernel for exactly
the reasons you mention above).  It felt a little sluggish for a native
kernel build though, and I'm not setup for cross-building so I stuck with
the 3.4 build.
 
 > How long would a useful run of trinity take?

It blew up in a minute or so of runtime when I tried last week.

 > I've got an autobuilder/autobooter setup here with a cross-section of current ARM
 > hardware (7 platforms and counting) that I mostly do boot testing on,
 > and I should add a smallish suite of testcases to the same. Trinity
 > would be a good candidate for that.

Feel free to mail me off-list if I can do anything to help out, though
hopefully things should build & run 'out of the box'.  You shouldn't
need any special command line args (though you might get inspiration
for ideas from the scripts/test-* harnesses)

	Dave

From: mzoran@crowfest.net (Michael Zoran)
Date: Fri, 25 Nov 2016 01:05:31 -0800
Subject: RPI3 doesn't boot in ARM64 mode on linux-next
In-Reply-To: <CAKv+Gu-SNWpAskP19Swr_YsW=uATuNXkvdWKBpWcoVC4ndFASQ@mail.gmail.com>
References: <1480041098.1504.1.camel@crowfest.net>
 <CAKv+Gu-SNWpAskP19Swr_YsW=uATuNXkvdWKBpWcoVC4ndFASQ@mail.gmail.com>
Message-ID: <1480064731.3309.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-11-25 at 08:12 +0000, Ard Biesheuvel wrote:
> On 25 November 2016 at 02:31, Michael Zoran <mzoran@crowfest.net>
> wrote:
> > Last night I did a build of linux-next and I'm finding that I can
> > no
> > longer get my RPI 3 to boot in arm64 mode anymore.??It seems to be
> > hanging very early in the boot process.
> > 
> > I know linux-next is going through a very large number of changes
> > now,
> > so does anybody know if arm64(not just the RPI 3) is just broken in
> > general at this point? 4.9rc6 is working fine.
> > 
> > I don't have a JTAG debugger, so it's a bit hard for me to
> > debug.??I've
> > actually been looking for a decent cheap JTAG debugger for awhile
> > now,
> > so if anybody knows of one in the < $300.00 range it might be a
> > good
> > self Christmas present.
> > 
> 
> Are you using earlycon?

No, but that's a good thing for me to try next.  I also found the
Segger J-Link on the web for $60 that I bought.  Hopefully one or the
other will work.

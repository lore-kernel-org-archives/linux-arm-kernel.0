From: tony@atomide.com (Tony Lindgren)
Date: Thu, 31 Aug 2017 10:43:19 -0700
Subject: [PATCH] scripts: make extract-vmlinux support armel/armhf
In-Reply-To: <20170831161957.GU20805@n2100.armlinux.org.uk>
References: <20170831153631.31026-1-rogershimizu@gmail.com>
 <20170831154941.GS20805@n2100.armlinux.org.uk>
 <CAEQ9gEmBv-fb2MbedSzs+dWtrq-ChXwiMrisyofZ7zfu+jADYA@mail.gmail.com>
 <20170831161957.GU20805@n2100.armlinux.org.uk>
Message-ID: <20170831174318.GM6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170831 09:21]:
> On Fri, Sep 01, 2017 at 01:05:16AM +0900, Roger Shimizu wrote:
> > On Fri, Sep 1, 2017 at 12:49 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> > > What's the use case - what are you using the output of this script with?
> > 
> > I already provided a use case, to trace a Debian kernel issue caused
> > by kernel size.
> > - https://bugs.debian.org/870185#50
> 
> Sorry, I haven't time to look - it needs me to use firefox on a
> different machine.  Maybe you could help by providing some details
> by email, otherwise I've got extra work to do at some point in the
> future (probably days away) if I remember (your mail will get buried).
> Much of my time is in front of a _textual_ _only_ interface, and elinks
> does not work with several modern SSL-only sites.
> 
> > I also see other people complaining this issue:
> >  - https://bugs.launchpad.net/linaro-ubuntu/+bug/1050453
> >  - https://bugs.linaro.org/show_bug.cgi?id=461
> > 
> > By a random web search, I find another blog post on how to dissamble the kernel.
> >  - https://blog.packagecloud.io/eng/2016/03/08/how-to-extract-and-disassmble-a-linux-kernel-image-vmlinuz/
> 
> Yea, all SSL sites, I'm not going to try elinks with them, I don't
> have the time to mess around.

I think the use case is to get the booted kernel size from zImage
to avoid overwriting dts or initramfs. Don't we already have that
at the end of zImage somewhere for kexec?

Regards,

Tony

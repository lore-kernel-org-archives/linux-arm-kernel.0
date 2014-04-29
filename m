From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Tue, 29 Apr 2014 07:41:16 -0700
Subject: [PATCH v2 00/12] scsi/NCR5380: fix debugging macros and
 #include structure
In-Reply-To: <CAOmrzk+kuepC7QR4uchP_zxk7-Bi7faiF-Z5jGX9KMcHn-7_9Q@mail.gmail.com>
References: <20140319123516.542623278@telegraphics.com.au>
 <1398532863.24466.2.camel@dabdike.int.hansenpartnership.com>
 <alpine.LNX.2.00.1404291202190.32739@nippy.intranet>
 <CAOmrzk+kuepC7QR4uchP_zxk7-Bi7faiF-Z5jGX9KMcHn-7_9Q@mail.gmail.com>
Message-ID: <1398782476.2218.20.camel@dabdike.int.hansenpartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-29 at 15:15 +1200, Michael Schmitz wrote:
> Finn,
> 
> On Tue, Apr 29, 2014 at 2:22 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> > On Sat, 26 Apr 2014, James Bottomley wrote:
> >
> >> OK, so this is a pretty big change to an unmaintained driver.  I'll take
> >> it if you're willing to maintain the driver afterwards ... in which case
> >> I need another patch to add you to the MAINTAINERS file.
> >
> > Sure, I'm happy to support these patches and future work I plan to do on
> > the driver.
> >
> > What additional responsibilities would come with adding my name the
> > MAINTAINERS file?
> >
> > Perhaps Michael and Sam would be interested in sharing the role, for atari
> > and sun3 NCR5380 drivers (?)
> 
> If you insist ...
> 
> (kidding - I"m OK with it if James thinks it's worth it)

As long as you understand how it works and how to fix it, the more the
merrier.  It gives me more people to yell at if something goes wrong
with the driver.

James

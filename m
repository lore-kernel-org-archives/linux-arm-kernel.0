From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Oct 2012 15:41:20 +0100
Subject: [PATCH 1/2] ARM: config: sort select statements alphanumerically
In-Reply-To: <CACRpkdba1q52bEDcWsd47QwXA-DNhq6PENf2M-tvZ6znYu+5yw@mail.gmail.com>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
 <E1TMfFr-0001Kt-W5@rmk-PC.arm.linux.org.uk>
 <CACRpkdba1q52bEDcWsd47QwXA-DNhq6PENf2M-tvZ6znYu+5yw@mail.gmail.com>
Message-ID: <20121012144119.GM28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 04:04:28PM +0200, Linus Walleij wrote:
> On Fri, Oct 12, 2012 at 3:26 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > As suggested by Andrew Morton:
> >
> >   This is a pet peeve of mine.  Any time there's a long list of items
> >   (header file inclusions, kconfig entries, array initalisers, etc) and
> >   someone wants to add a new item, they *always* go and stick it at the
> >   end of the list.
> >
> >   Guys, don't do this.  Either put the new item into a randomly-chosen
> >   position or, probably better, alphanumerically sort the list.
> >
> > lets sort all our select statements alphanumerically.  This commit was
> > created by the following perl:
> 
> I applied this and tried to configure the Nomadik defconfig,
> and I get this, sadly:

Yes, I've just fixed those.  Unfortunately, the patch is soo large that
it trips the mailing list size limit, and has to be manually approved,
so I'm not sure I can call on the list maintainers again today to do the
approval thing.

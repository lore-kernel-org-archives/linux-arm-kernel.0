From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Feb 2013 13:42:07 +0000
Subject: [PATCH v2 00/13] drivers: mailbox: framework creation
In-Reply-To: <CACRpkdZayg-X11ZRnh2Z0i+egBn8Fhwya-6_Yr8wcv+6s0CVqQ@mail.gmail.com>
References: <1360645032-9668-1-git-send-email-s-anna@ti.com>
 <CACRpkdZayg-X11ZRnh2Z0i+egBn8Fhwya-6_Yr8wcv+6s0CVqQ@mail.gmail.com>
Message-ID: <20130213134207.GN17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 02:36:32PM +0100, Linus Walleij wrote:
> On Tue, Feb 12, 2013 at 5:56 AM, Suman Anna <s-anna@ti.com> wrote:
> 
> > I have hosted the series at [3].
> > [3] https://github.com/sumananna/mailbox/commits/dbx500-prcmu-mailbox
> 
> Suman, I suggest you ask Stepgen Rothwell to include this
> branch into the linux-next tree, so we can get some
> rotation of this stuff in preparation for the v3.10 merge
> window. (It's not going in now anyway.)

Best wait until after v3.9-rc1 - remember that linux-next is supposed to
be a staging tree for the _next_ merge window only.

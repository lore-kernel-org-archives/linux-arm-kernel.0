From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Jun 2013 22:20:53 +0200
Subject: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
In-Reply-To: <CANqRtoQVqfZaGbuVLiY8PiMTjVpt8VDs7KZyqnqjud+1yZtvQQ@mail.gmail.com>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <201306141629.26580.arnd@arndb.de>
 <CANqRtoQVqfZaGbuVLiY8PiMTjVpt8VDs7KZyqnqjud+1yZtvQQ@mail.gmail.com>
Message-ID: <201306172220.54015.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013, Magnus Damm wrote:
> On Fri, Jun 14, 2013 at 11:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 14 June 2013, Magnus Damm wrote:
> >> > If still possible, would be good to delay removing this board until we
> >> > complete our discussion.
> >>
> >> If fine with keeping the board if someone can show me progress in the
> >> area of INTC DT support. Recently I have not seen anything.
> >
> > As mentioned the last time we discussed this, I'm fine with using the
> > existing code and "legacy" irqdomain for the older INTC implementations,
> > as long as all the new ones can use your new generic code.
> 
> Thanks for explaining once again. Do you have any issues with us
> reducing the number of supported boards and/or SoCs?

No, I'm sure you know who the users of the board files in upstream kernels
are. If someone comes up with a good reason why one of the files is
needed after all, we can always revert the removal at a later point.

I'm definitely in favor of removing known unused code that gets in the way
of progress and adding clean code as quickly as we can review it.

	Arnd

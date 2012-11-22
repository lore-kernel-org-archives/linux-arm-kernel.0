From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Nov 2012 07:09:43 +0100
Subject: [PATCH] ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
In-Reply-To: <20121122025357.GG15800@titan.lakedaemon.net>
References: <1352792590-20052-1-git-send-email-iwamatsu@nigauri.org>
 <20121113123739.GS22042@titan.lakedaemon.net>
 <CABMQnVKPyEp-cm_M_Y4rSU_tNLHL0fhUKUUgZkTkV+8MhnjVdA@mail.gmail.com>
 <CABMQnVL7bd7Om-7nZ33Y336PPtdMLmMWx63YwtMOZf5NftkeOw@mail.gmail.com>
 <20121122025357.GG15800@titan.lakedaemon.net>
Message-ID: <20121122060943.GE9177@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 09:53:57PM -0500, Jason Cooper wrote:
> On Thu, Nov 22, 2012 at 08:43:46AM +0900, Nobuhiro Iwamatsu wrote:
> > On Wed, Nov 14, 2012 at 4:54 AM, Nobuhiro Iwamatsu <iwamatsu@nigauri.org> wrote:
> > > On Tue, Nov 13, 2012 at 9:37 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> > >> On Tue, Nov 13, 2012 at 04:43:09PM +0900, Nobuhiro Iwamatsu wrote:
> > >>> Add support for Plat'Home OpenBlocks A6 using the device tree
> > >>> where possible.
> > >>> This commit supports SATA, USB, ether and serial console.
> > >>>
> > >>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > >>> ---
> > >>> V2:
> > >>>   - Remove unnecessary value from bootargs.
> > >>>   - Update comment for MPP table.
> > >>>   - Remove kirkwood_uart0_init().
> > >>
> > >> Thanks for the patch.  One small note.  In the future, please add a 'V2'
> > >> to the subject line, eg "[PATCH V2] ...".  It really helps us keep track of
> > >> which one to merge.
> > >
> > > Although I knew about it , I forgot adding "V2".
> > >
> > >>
> > >> No need to resend, I'll keep track of it since I'm about to pull
> > >> everything together over the next few days.
> > 
> > Where have you managed this patch?  http://git.infradead.org/ ?
> 
> Yes, mostly on my local machine currently.  I'm busy sorting everything.
> ;-)
> 
> > I would like to put this into 3.8.  And I would like to follow some
> > functions (clock frame work etc.) updated.
> 
> I'm not sure what you mean by the second sentence.  At any rate, Thomas
> has included your patch in his pull request,

Hi Jason

What out for the difference between OpenBlocks A6 and AX4. A6 is
kirkwood, AX4 is XP. I've seen patches from Thomas for AX4. I don't
remember patches for A6 from Thomas. For A6 it would be nice to have
pinctrl, convert EHCI to DT, etc.

Happy Thanks Giving,

	 Andrew

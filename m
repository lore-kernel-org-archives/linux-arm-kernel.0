From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 12 Oct 2012 09:51:07 +1100
Subject: new branch for linux-next [Was: [PATCH v6 0/3] Updated
 Cortex-M3 series]
In-Reply-To: <20121008154659.GY4625@n2100.arm.linux.org.uk>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20121008154325.GF18531@pengutronix.de>
 <20121008154659.GY4625@n2100.arm.linux.org.uk>
Message-ID: <20121012095107.4eb7330ff3429809fd48108a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Mon, 8 Oct 2012 16:47:00 +0100 Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>
> On Mon, Oct 08, 2012 at 05:43:25PM +0200, Uwe Kleine-K?nig wrote:
> > 
> > I already tried several times to get feedback from Russell King (as you
> > probably know he's the ARM maintainer and busy most of the time) for my
> > series to support Cortex-M3 machines. As I think the outcome will
> > probably (at least) be that it should be included in next for some time
> > first (as for example Arnd Bergmann already suggested), can you please
> > add
> > 
> > 	git://git.pengutronix.de/git/ukl/linux-2.6.git for-next
> > 
> > to your tree? I'd suggest adding it after arm and arm-soc.
> > I intend to use this branch later for efm32 support (which depends on
> > the Cortex-M3 stuff).
> > 
> > Currently the branch is still empty, but I intend to fill it with what I
> > consider to be applyable after I did some more testing. (Mainly to
> > assert it still does what it did when I developed it on an older base.)
> > 
> > @Russell: I hope this is OK for you. If not, I'm sure you'll protest.
> 
> Well, I think the patches are mostly fine but I do think more eyes are
> needed on them first.  I heard today that some people will be looking
> at your Cortex M3 stuff, and hopefully that should move things forward.

I generally don't add new trees to linux-next during the merge window,
so, if you don't hear from me that I have added it, please remind me
about this after Linus releases v3.7-rc1.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121012/290f4d2b/attachment.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Mar 2014 10:16:49 +0100
Subject: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
In-Reply-To: <20140311205405.GA10228@spo001.leaseweb.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140303104042.GU607@lukather>
 <20140311205405.GA10228@spo001.leaseweb.com>
Message-ID: <20140312091649.GU2815@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

On Tue, Mar 11, 2014 at 09:54:05PM +0100, Wim Van Sebroeck wrote:
> > On Fri, Feb 07, 2014 at 10:29:23PM +0100, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > This is the second version of the A10 watchdog compatible changes.
> > > The only difference with the v1 being that we're now droping the old
> > > compatibles, instead of keeping them, since the DT maintainers said it was
> > > fine.
> > > 
> > > Thanks,
> > > Maxime
> > > 
> > > Maxime Ripard (3):
> > >   watchdog: sunxi: Change compatibles
> > >   ARM: sunxi: Add the new watchog compatibles to the reboot code
> > >   ARM: sunxi: dt: Update the watchdog compatibles
> > 
> > Ping?
> 
> I'm OK with the patches, but what is the preferred way to get them upstream?
> via watchdog tree or via arch/soc tree?

Since it touches the machine restart code, I'd prefer to merge it
myself if it's ok?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/775f5112/attachment.sig>

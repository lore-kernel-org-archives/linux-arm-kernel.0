From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Dec 2013 14:22:40 -0600
Subject: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
In-Reply-To: <230CBA6E4B6B6B418E8730AC28E6FC7E0415C84D@DFLE11.ent.ti.com>
References: <20131212214306.GS1939@saruman.home>
 <1386884755-12366-1-git-send-email-balbi@ti.com>
 <52AA54E4.5000606@ti.com>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C786@DFLE11.ent.ti.com>
 <20131213195431.GF5292@saruman.home>
 <230CBA6E4B6B6B418E8730AC28E6FC7E0415C84D@DFLE11.ent.ti.com>
Message-ID: <20131213202240.GK5292@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 02:18:42PM -0600, Kwok, WingMan wrote:
> 
> > -----Original Message-----
> > From: Balbi, Felipe
> > Sent: Friday, December 13, 2013 2:55 PM
> > To: Kwok, WingMan
> > Cc: Shilimkar, Santosh; Balbi, Felipe; Linux USB Mailing List;
> > kgene.kim at samsung.com; Linux ARM Kernel Mailing List; linux-samsung-
> > soc at vger.kernel.org; Linux OMAP Mailing List
> > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM support
> > 
> > On Fri, Dec 13, 2013 at 10:04:38AM -0600, Kwok, WingMan wrote:
> > > Hello
> > >
> > > > -----Original Message-----
> > > > From: Shilimkar, Santosh
> > > > Sent: Thursday, December 12, 2013 7:29 PM
> > > > To: Balbi, Felipe
> > > > Cc: Linux USB Mailing List; kgene.kim at samsung.com; Linux ARM Kernel
> > > > Mailing List; linux-samsung-soc at vger.kernel.org; Linux OMAP Mailing
> > > > List; Kwok, WingMan
> > > > Subject: Re: [PATCH v2 1/7] usb: dwc3: keystone: add basic PM
> > > > support
> > > >
> > > > On Thursday 12 December 2013 04:45 PM, Felipe Balbi wrote:
> > > > > A bare-minimum PM implementation which will server as building
> > > > > block for more complex
> > > > s/server/serve ;-)
> > > > > PM implementation in the future.
> > > > >
> > > > > At the least will not leave clocks on unnecessarily when e.g.  a
> > > > > user write mem to /sys/power/state.
> > > > >
> > > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > > ---
> > > > >
> > > > > improve error path a little bit.
> > > > >
> > > > We will test this out. Thanks for the patch Felipe.
> > > >
> > >
> > > I have tested the patch and the keystone usb driver continues to
> > > function, though I can't test suspend at this time as the rest of the
> > > system does not that functionality yet.
> > 
> > Thanks, should I add your Tested-by ?
> 
> Yes please.

you need to reply with Tested-by: Your Name <your.email@domain.com> just
to make it all official. Sorry

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/6bed2d1d/attachment-0001.sig>

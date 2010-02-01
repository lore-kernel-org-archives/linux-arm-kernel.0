From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sun, 31 Jan 2010 18:01:17 -0800
Subject: [PATCH v6] input: IMX: add imx-keypad driver to support the
	Keypad Port present in the imx application processors family.
In-Reply-To: <1264945351.2433.10.camel@realization>
References: <1264852407.2587.4.camel@realization>
	<20100131090802.GD12320@core.coreip.homeip.net>
	<1264945351.2433.10.camel@realization>
Message-ID: <20100201020117.GA24188@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

On Sun, Jan 31, 2010 at 02:42:31PM +0100, Alberto Panizzo wrote:
> On dom, 2010-01-31 at 01:08 -0800, Dmitry Torokhov wrote:
> > Hi Alberto,
> > 
> > On Sat, Jan 30, 2010 at 12:53:27PM +0100, Alberto Panizzo wrote:
> > > 
> > > Changes in v6:
> > > -MXC to IMX pattern change (apart of Kconfig dependencies)
> > > -Comment style fixes
> > > -Greater check delay in debouncing process (10). 
> > > -Improve the usage of keypad->exit_flag: now it is false only
> > between open and 
> > >  close functions. And if we handle an interrupt out there, leave all
> > interrupts
> > >  masked, and wait for another open to re enable they.
> > > -Remove unnecessary "free events" mechanism (tested with evtest).
> > > 
> > 
> > I took the liberty of making some changes to the driver, could you
> > please give the patch below a try and if I did not mess it up I will
> > fold it into your v6 version and apply to next.
> > 
> > Thank you.
> > 
> > -- 
> > Dmitry 
> 
> For me it is ok. Your patch looks good and I tested your changes and all
> goes well.

Great, thanks a lot.

> I have to work on my English and other changes make the 
> source code more readable.
> Dmitry, put also your Signed-off line in v6 patch after merge if you
> feel to wont this. (I've already thought to ask you this before this
> patch fix) You help me a lot on building this version and an Acked-by
> maybe is not fair about your work.

Yes, I will fold this patch into your original v6 patch and will add my
sign-off. BTW, adding sign-off does not imply in any way that a person
had more or less involvement in the development of a driver/feature;
this is just to track the path of patricular code reaching mainline.
I am adding my sign-offs to all patches that are applied to my tree as
do all the other maintainers, the authorship of the patch is conveyed
via git's 'author' field.

OK, so the driver is applied to the 'next' branch of my tree and should
be in mainline when 2.6.34 merge window opens.

Thank you.

-- 
Dmitry

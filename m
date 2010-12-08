From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 8 Dec 2010 16:52:50 +0000
Subject: [RFC PATCH 02/13] picoxcell: add support for AXI bus snoopers
In-Reply-To: <20101208161013.GL9777@n2100.arm.linux.org.uk>
References: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
	<1290506774-17895-3-git-send-email-jamie@jamieiles.com>
	<20101208161013.GL9777@n2100.arm.linux.org.uk>
Message-ID: <20101208165250.GF2716@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 04:10:13PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 23, 2010 at 10:06:03AM +0000, Jamie Iles wrote:
> > diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
> > index 4469a78..07eaa9b 100644
> > --- a/arch/arm/mach-picoxcell/picoxcell_core.c
> > +++ b/arch/arm/mach-picoxcell/picoxcell_core.c
> > @@ -71,6 +71,7 @@ static ssize_t part_show(struct sys_device *sysdev,
> >  			 struct sysdev_attribute *attr, char *buf)
> >  {
> >  	const char *part = picoxcell_get_partname();
> > +
> >  	return snprintf(buf, PAGE_SIZE, "%s\n", part);
> >  }
> 
> Shouldn't this be in the first patch?
Indeed, not sure how I missed that.

Jamie

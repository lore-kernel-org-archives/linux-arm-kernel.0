From: simon@sequanux.org (Simon Guinot)
Date: Fri, 22 Oct 2010 12:25:13 +0000
Subject: [PATCH v3] hwmon: add generic GPIO fan driver
In-Reply-To: <1287712301.9690.376.camel@groeck-laptop>
References: <20101021223555.GT29120@kw.sim.vm.gnt>
	<1287701059-2226-1-git-send-email-simon@sequanux.org>
	<1287712301.9690.376.camel@groeck-laptop>
Message-ID: <20101022122513.GV29120@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Thu, Oct 21, 2010 at 06:51:41PM -0700, Guenter Roeck wrote:
> Hi Simon,
> 
> On Thu, 2010-10-21 at 18:44 -0400, Simon Guinot wrote:
> > From: Simon Guinot <sguinot@lacie.com>
> > 
> > This patch adds hwmon support for the GPIO connected fan.
> > 
> I rephrased this to ".. for fans connected to GPIO pins."
> 
> > Platform specific informations as GPIO pinout and speed conversion array
> > (rpm from/to GPIO value) are passed to the driver via platform_data.
> > 
> > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> 
> [ ... ]
> > +static int __devinit gpio_fan_probe(struct platform_device *pdev)
> > +{
> > +       int err = 0;
> 
> and this variable initialization is not needed.
> 
> Otherwise looks good. Applied with the above changed to my -next tree.
> 
> I'll let it rest there for a couple of days. Unless some unforeseen
> problems show up, it might just make it into .37.

Thanks for your help and your patience.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101022/df0cc95b/attachment.sig>

From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 24 Sep 2015 09:14:03 +0200
Subject: [PATCH v3 6/9] gpiolib-sysfs: Show gpio-name in
 /sys/class/gpio/gpio*/name
In-Reply-To: <CACRpkdZ4C25NsrCEHS0hxFx+AkjGfC7cyZeMvixOyoADtcvbmA@mail.gmail.com>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-7-git-send-email-mpa@pengutronix.de>
 <CACRpkdZ4C25NsrCEHS0hxFx+AkjGfC7cyZeMvixOyoADtcvbmA@mail.gmail.com>
Message-ID: <20150924071403.GW32203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 06:07:51PM -0700, Linus Walleij wrote:
> On Fri, Aug 14, 2015 at 7:11 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> 
> > This patch adds a sysfs attribute 'name' to gpios that were exported. It
> > exposes the newly added name property of gpio descriptors.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> 
> The previous hunk adding the name to the sysfs ABI should
> be in this patch.
> 
> But I have a problem with this. What is the rationale? The directory
> that contains the file already has this name. Why should this
> information be duplicated?

No reason for that. As described in the summary, I wasn't sure if this
makes sense but included it anyway from the last series version. So it
can simply be dropped.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/3ca9ff0d/attachment.sig>

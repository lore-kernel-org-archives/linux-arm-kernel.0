From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 15 Oct 2012 11:19:28 -0700
Subject: [PATCH RFC 2/6 v3] gpio: Add sysfs support to block GPIO API
In-Reply-To: <20121015180702.GA12801@game.jcrosoft.org>
References: <1350069085-13283-1-git-send-email-stigge@antcom.de>
 <1350069085-13283-3-git-send-email-stigge@antcom.de>
 <20121015180702.GA12801@game.jcrosoft.org>
Message-ID: <20121015181928.GB27923@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 08:07:02PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 21:11 Fri 12 Oct     , Roland Stigge wrote:
> > This patch adds sysfs support to the block GPIO API.
> > 
> > Signed-off-by: Roland Stigge <stigge@antcom.de>
> > 
> > ---
> >  Documentation/ABI/testing/sysfs-gpio |    6 
> >  drivers/gpio/gpiolib.c               |  226 ++++++++++++++++++++++++++++++++++-
> >  include/asm-generic/gpio.h           |   11 +
> >  include/linux/gpio.h                 |   13 ++
> >  4 files changed, 254 insertions(+), 2 deletions(-)
> I really don't like this sysfs we need to add a specific device with ioctl

Why?

> I put Greg in Cc

Again, why?

greg k-h

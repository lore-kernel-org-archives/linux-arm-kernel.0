From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 10 Sep 2012 11:07:56 -0700
Subject: [PATCH v2 1/6] usb: pxa27x_udc: remove IRQ_USB define
In-Reply-To: <CAMPhdO9pyVDaR03Cy53gXbPttbnekaejuP_60qARttUuaBUwWg@mail.gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
 <1346960563-18689-2-git-send-email-robherring2@gmail.com>
 <CAMPhdO9pyVDaR03Cy53gXbPttbnekaejuP_60qARttUuaBUwWg@mail.gmail.com>
Message-ID: <20120910180756.GD31046@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 11:56:46AM +0800, Eric Miao wrote:
> On Fri, Sep 7, 2012 at 3:42 AM, Rob Herring <robherring2@gmail.com> wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > IRQ_USB was implicitly included by gpio.h. Use the existing variable
> > instead of IRQ_USB.
> >
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Eric Miao <eric.y.miao@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
> 
> Greg, guess this can go through the ARM tree.

That's fine, but note, I'm not the drivers/usb/gadget maintainer, Felipe
needs to know about this as well.

Rob, the tool, scripts/get_maintainer.pl is your friend, please use it :)

greg k-h

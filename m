From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 May 2013 09:17:35 +0900
Subject: [PATCH 1/2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
In-Reply-To: <CACRpkdZxWsJuvrtH-=VVqAGUCpdgS3W52R4tw5-_QGpggB+1uw@mail.gmail.com>
References: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
 <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
 <CACRpkdZxWsJuvrtH-=VVqAGUCpdgS3W52R4tw5-_QGpggB+1uw@mail.gmail.com>
Message-ID: <20130531001735.GA26684@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 10:08:56PM +0200, Linus Walleij wrote:
> On Thu, May 30, 2013 at 12:28 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> 
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > The USB_OVCn pins are alternate options for USB over-current detection
> > when using a 3.3V USB interface. As they're not mandatory they can be
> > used independently of the USB PENC pins. Don't group the USB_OVCn and
> > PENC pins to avoid conflicts when the USB_OVCn pins are used by another
> > function.
> >
> > Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> OK, Acked-by, do you want me to take this as a fix in the pinctrl
> tree for v3.10?
> 
> Just asking because Simon usually takes everything else relating to
> the SH. ...

This was a pull request from my tree to arm-soc, so thats they way
I was planning to handle things.

Olof, Arnd,

should I re-spin the pull request to include Linus's ack?

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 22:08:56 +0200
Subject: [PATCH 1/2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
In-Reply-To: <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
References: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
 <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CACRpkdZxWsJuvrtH-=VVqAGUCpdgS3W52R4tw5-_QGpggB+1uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 12:28 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> The USB_OVCn pins are alternate options for USB over-current detection
> when using a 3.3V USB interface. As they're not mandatory they can be
> used independently of the USB PENC pins. Don't group the USB_OVCn and
> PENC pins to avoid conflicts when the USB_OVCn pins are used by another
> function.
>
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

OK, Acked-by, do you want me to take this as a fix in the pinctrl
tree for v3.10?

Just asking because Simon usually takes everything else relating to
the SH. ...

Yours,
Linus Walleij

From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 10 Jun 2015 21:09:49 +0200
Subject: [PATCH v3 0/2] USB OTG PHY driver for NXP LPC18xx family
In-Reply-To: <1432922617-11512-1-git-send-email-manabian@gmail.com>
References: <1432922617-11512-1-git-send-email-manabian@gmail.com>
Message-ID: <CAGhQ9VzoZN0wow6csD7Mq58CFk31DGup676NoO=hyqnuAwNQwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 29 May 2015 at 20:03, Joachim Eastwood <manabian@gmail.com> wrote:
> This patch set adds support for the internal USB OTG PHY found
> on NXP LPC18xx and LPC43xx devices. Driver takes care of
> enabling the PHY and setting the clock rate which is need for
> USB0 support on this platform.
>
> This version address the comments from Kishon Vijay Abraham I.
>
> Changes in v3:
>  - depend on MFD_SYSCON
>
> Changes in v2:
>  - use PTR_ERR_OR_ZERO in phy driver
>  - rename binding doc
>  - update doc commit message
>
> Base support for this platform can now be found in arm-soc next.
>
> Joachim Eastwood (2):
>   phy: add lpc18xx usb otg phy driver
>   phy: dt bindings: add XP LPC18xx/43xx USB OTG PHY bindings

Do you have any more comments on the patches or are they okey now?


regards,
Joachim Eastwood

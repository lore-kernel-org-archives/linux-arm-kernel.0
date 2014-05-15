From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 15 May 2014 15:55:51 +0530
Subject: [PATCH] ARM: davinci: remove checks for CONFIG_USB_MUSB_PERIPHERAL
In-Reply-To: <1400149025.20469.22.camel@x220>
References: <1400149025.20469.22.camel@x220>
Message-ID: <5374962F.2050004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 May 2014 03:47 PM, Paul Bolle wrote:
> The Kconfig symbol USB_MUSB_PERIPHERAL was removed in v3.1. The last two
> checks for its macro now always evaluate to false. So remove these
> checks.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Eyeball tested only.
> 
> This is just a straightforward cleanup. It does remove a comment. Is
> that comment still useful? Anyhow, I do wonder whether a proper fix is
> possible here. Perhaps Greg or Felipe knows: it is their commit
> 622859634a66 ("usb: musb: drop a gigantic amount of ifdeferry") that
> removed USB_MUSB_PERIPHERAL. On the other hand I noticed that config
> USB_MUSB_DAVINCI depends on BROKEN. So maybe properly fixing just this
> small problem doesn't buy us much.

Yes, it doesn't buy us much. I will still apply this anyway. The next
person can save time spent searching for non-existing symbols.

Thanks,
Sekhar

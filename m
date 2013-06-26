From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Jun 2013 18:38:21 -0700
Subject: [PATCH] ARM: Make multi_v7_defconfig usable on hardware
In-Reply-To: <1372210565-22962-1-git-send-email-olof@lixom.net>
References: <1372210565-22962-1-git-send-email-olof@lixom.net>
Message-ID: <CAOesGMg2du8PsOGy1kdePT4vMsWie1N8hmjCxRqr-LS6RAC07g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 6:36 PM, Olof Johansson <olof@lixom.net> wrote:

> +CONFIG_DEBUG_LL=y
> +CONFIG_DEBUG_OMAP2PLUS_UART=y
> +CONFIG_DEBUG_OMAP4UART3=y

Clearly not supposed to be there for the posted version, my bad --
will take those out before committing.

(this will go on top of next/late, btw).


-Olof

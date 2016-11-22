From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 21 Nov 2016 18:53:27 -0800
Subject: [PATCH 1/6] apalis-tk1: remove spurious new lines
In-Reply-To: <1479773647-14726-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1479773647-14726-1-git-send-email-marcel.ziswiler@toradex.com>
 <1479773647-14726-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <CAADWXX-hfEP+OcztBsWQcPeGXNAXvFA+QGk_qLXaL1APkc1WOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

.Marcel,

your git-sendemail emails get marked as spam, because:

       dmarc=fail (p=QUARANTINE dis=NONE) header.from=toradex.com

which is probably because the toradex.com dmarc rule requires DKIM,
but you lack a DKIM signature.

The most common case is that you've misconfigured your git-send-email
thing to go through a smtp server that is *not* the proper toradex.com
smtp server, and so you don't have a dkim signature.

Looking at your non-git-send-email emails, that do have DKIM
signatures, they've gone through
HE1PR05MB1881.eurprd05.prod.outlook.com (I'm sorry for your pain),
while your git-send-email ones seem to go through
"mrelay.perfora.net".

And obviouslty perfora.net is not adding the DKIM signatures for toradex.com

               Linus

On Mon, Nov 21, 2016 at 4:14 PM, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
> Remove some spurious new lines.
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>
>  arch/arm/boot/dts/tegra124-apalis-eval.dts |  1 -
>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 12 ------------
>  2 files changed, 13 deletions(-)
[...]

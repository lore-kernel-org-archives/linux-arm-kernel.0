From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Wed, 04 Jun 2014 09:23:22 +0200
Subject: Tegra 2 T20 NAND Flash Support
In-Reply-To: <1401866283.2173.3.camel@tellur>
References: <538E6FB5.5020806@ziswiler.com> <1401866283.2173.3.camel@tellur>
Message-ID: <538EC96A.4050702@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 09:18 AM, Lucas Stach wrote:
> I took the Linux Tegra NAND driver from Thierry and cleaned it up quite
> a bit. It now works with both ONFI and non-ONFI NAND, at least for
> reading. Writing doesn't quite work yet and I've got side-tracked with
> other stuff.
>
> If you are interested in moving this forward I can put up my WIP patches
> to some public location.

Sounds great, yes. That would be perfect, thanks.

We even once got an universal NAND test infrastructure from Micron based 
on a re-worked Colibri T20 which we could use to validate it with 
various NAND flash parts.

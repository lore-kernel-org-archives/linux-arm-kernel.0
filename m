From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 09:55:37 +0100
Subject: sun4i drm device tree
In-Reply-To: <70275161-0167-fa2e-3557-d15b8244c04d@orpaltech.com>
References: <70275161-0167-fa2e-3557-d15b8244c04d@orpaltech.com>
Message-ID: <20180122085537.2cenqvvpjrbrzf7g@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 22, 2018 at 11:15:58AM +0300, Sergey Suloev wrote:
> as far as I understand it is possible now to compile sun4i-drm for
> a64 SoC.

Well, compile yes, but the A64 isn't supported at the moment, so
compiling it won't get you very far. Where did you get that info from?

> But it seems that there should be changes to device tree files
> (arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi,
> arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi) too.
> 
> Can you PLEASE give a ref to a patch or explain device tree changes
> needed?

And even if it was supported, we'd need a lot more informations to
help you. For example, which boards, with which video outputs

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180122/b2cd32fa/attachment.sig>

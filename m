From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 26 Jan 2018 09:07:23 +0100
Subject: sun4i drm device tree
In-Reply-To: <1844c194-1a4b-2a39-8798-adc4dc83a6c1@orpaltech.com>
References: <70275161-0167-fa2e-3557-d15b8244c04d@orpaltech.com>
 <20180122085537.2cenqvvpjrbrzf7g@flea.lan>
 <1844c194-1a4b-2a39-8798-adc4dc83a6c1@orpaltech.com>
Message-ID: <20180126080723.cdortgeqgbxqfkwh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 10:05:08AM +0300, Sergey Suloev wrote:
> On 01/22/2018 11:55 AM, Maxime Ripard wrote:
> > On Mon, Jan 22, 2018 at 11:15:58AM +0300, Sergey Suloev wrote:
> > > But it seems that there should be changes to device tree files
> > > (arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi,
> > > arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi) too.
> > > 
> > > Can you PLEASE give a ref to a patch or explain device tree changes
> > > needed?
> > And even if it was supported, we'd need a lot more informations to
> > help you. For example, which boards, with which video outputs
>
> Maxime, it is still unclear about sun4i-drm on aarch64: should it work on
> NanoPi A64 ?

No

> Are there device tree patches for it ?

No

> Can you (or someone else) share any info about the status, PLEASE. That may
> be helpful for many people, I guess.

It's documented here:
https://linux-sunxi.org/Mainlining_Effort#Status_Matrix

With a status of either WiP or not supported depending on the outputs.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180126/b3a09012/attachment.sig>

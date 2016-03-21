From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Mar 2016 19:19:43 +0100
Subject: [linux-sunxi][PATCH v2 3/5] ARM: dts: sunxi: Add the SPDIF to
 the A10 and A20
In-Reply-To: <1458576642-4078-4-git-send-email-codekipper@gmail.com>
References: <1458576642-4078-1-git-send-email-codekipper@gmail.com>
 <1458576642-4078-4-git-send-email-codekipper@gmail.com>
Message-ID: <20160321181943.GF30977@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 05:10:40PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the SPDIF transceiver controller and clock to the A10 and
> A20 dtsi.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi | 24 ++++++++++++++++++++++++

Sorry, I missed that earlier, but please make separate patches for
those two DTS.

It also applies for the other patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160321/cbbe10ed/attachment.sig>

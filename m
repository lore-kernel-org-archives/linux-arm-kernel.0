From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 16 Nov 2013 07:32:35 +0100
Subject: [PATCH] ARM: sunxi: dt: add EMAC aliases
In-Reply-To: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
References: <1384546600-14384-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20131116063235.GH3538@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Fri, Nov 15, 2013 at 05:16:40PM -0300, Emilio L?pez wrote:
> U-Boot uses the ethernet0 alias to locate the right node to fill in
> the MAC address of the first ethernet interface. This patch adds the
> alias on all the sunxi boards with EMAC and an ethernet port. In this
> way, people using ethernet in U-Boot (eg, for tftp) can keep a consistent
> address on both U-Boot and Linux with no additional effort.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
> 
> Hi everyone,
> 
> I have tested this on a cubieboard2 and found it to work as intended, 
> and I don't see why it wouldn't work on the other boards, given that 
> the U-Boot codebase is shared. It may be worth submitting this for 
> 3.13-rc0, but I'm not the one that has to make that call :)
> 
> Cheers,
> 
> Emilio
> 
>  arch/arm/boot/dts/sun4i-a10-a1000.dts            | 1 +
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts       | 1 +
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts        | 4 ++++
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 4 ++++
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      | 4 ++++
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  | 4 ++++
>  6 files changed, 18 insertions(+)

I think it would make more sense to add it to the dtsi.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/aeaed47a/attachment.sig>

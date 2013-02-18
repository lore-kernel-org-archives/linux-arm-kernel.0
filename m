From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Feb 2013 20:22:40 +0200
Subject: [PATCH, RFC 7/8] ARM: dts: am4372: initial support
In-Reply-To: <c9c131c0508b875c0893e8557504372a1564568a.1361186097.git.afzal@ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <c9c131c0508b875c0893e8557504372a1564568a.1361186097.git.afzal@ti.com>
Message-ID: <20130218182240.GA10755@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 18, 2013 at 05:08:16PM +0530, Afzal Mohammed wrote:
> +		uart1: serial at 44e09000 {
> +			compatible = "ti,am4372-uart","ti,omap2-uart";
> +			clock-frequency = <48000000>;
> +			reg = <0x44e09000 0x2000>;
> +			interrupts = <0 72 0x4>;

missing ti,hwmods ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/6d5d3ac6/attachment.sig>

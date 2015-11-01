From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 1 Nov 2015 10:29:29 +0100
Subject: [PATCH] arm: sun7i: Add sun7i-a20-icnova-swac.dts
In-Reply-To: <1445597772-983-1-git-send-email-sr@denx.de>
References: <1445597772-983-1-git-send-email-sr@denx.de>
Message-ID: <20151101092929.GM6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Fri, Oct 23, 2015 at 12:56:12PM +0200, Stefan Roese wrote:
> +&reg_dcdc2 {
> +	regulator-always-on;
> +	regulator-min-microvolt = <1000000>;
> +	regulator-max-microvolt = <1450000>;
> +	regulator-name = "vdd-cpu";
> +};

The upper boundary for this regulator is 1.4V.

I've fixed this and applied the patch. It's queued for 4.5, and I will
only publish that branch when 4.4-rc1 will be released, so don't worry
if the patch doesn't show up before a while.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151101/d99d0426/attachment.sig>

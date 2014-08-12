From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 Aug 2014 17:58:52 +0100
Subject: [PATCH 1/6] ARM: dts: Create fragment for tps65090 PMU
In-Reply-To: <1407861868-20097-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1407861868-20097-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407861868-20097-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140812165852.GT17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 06:44:23PM +0200, Javier Martinez Canillas wrote:
> The tps65090 is a Power Management Unit (PMU) used in several
> boards so the same information is described on different DTS.
> It is better to create a .dtsi fragment that can be included.

Why is it better to do this?

> +	regulators {
> +		tps65090_dcdc1: dcdc1 {
> +		};
> +

It appears to be largely content free, exactly the same effect should be
achieved by removing the entire regulators node.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140812/c473d347/attachment.sig>

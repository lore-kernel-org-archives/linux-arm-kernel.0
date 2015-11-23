From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Nov 2015 21:45:39 +0100
Subject: [PATCH] ARM: dts: sun8i: Add Orange Pi PC support
In-Reply-To: <1447825233-3325-1-git-send-email-wens@csie.org>
References: <1447825233-3325-1-git-send-email-wens@csie.org>
Message-ID: <20151123204539.GA32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 18, 2015 at 01:40:33PM +0800, Chen-Yu Tsai wrote:
> +&usbphy {
> +	/* USB VBUS is always on */
> +	status = "okay";
> +};

You can tie it to reg_5v0 then :)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/c3e08e4a/attachment-0001.sig>

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Jul 2017 15:01:25 +0200
Subject: [PATCH v3] phy: allwinner: phy-sun4i-usb: Add log when probing
In-Reply-To: <20170704123703.18916-1-quentin.schulz@free-electrons.com>
References: <20170704123703.18916-1-quentin.schulz@free-electrons.com>
Message-ID: <20170704130125.seri6wtys42ux4vj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 02:37:03PM +0200, Quentin Schulz wrote:
> When phy-sun4i-usb's probing fails, it does not print the reason in
> kernel log, forcing the developer to edit this driver to add info logs.
> This commit makes the kernel print the reason of phy-sun4i-usb's probing
> failure or a success message.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170704/4077db37/attachment.sig>
